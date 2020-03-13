
DOCKER_CONTAINER_NAME := synapse-frontend
DOCKER_IMAGE_NAME := 242617/synapse-frontend


.PHONY: docker-build
docker-build:
	docker build \
		-t ${DOCKER_IMAGE_NAME} \
		.

.PHONY: docker-debug
docker-debug: docker-build
	docker run \
		--rm \
		-p 4443:443 \
		-v `pwd`/www/:/usr/share/nginx/html/ \
		-v `pwd`/keys/:/etc/letsencrypt/live/synapse.chill-out.ru/ \
		--name ${DOCKER_CONTAINER_NAME} \
		${DOCKER_IMAGE_NAME}

.PHONY: docker-save
docker-save:
	docker save -o ${DOCKER_CONTAINER_NAME}.tar ${DOCKER_IMAGE_NAME}
	du -h ${DOCKER_CONTAINER_NAME}.tar


.PHONY: deploy
deploy: docker-build docker-save
	. ./env.sh; \
		rsync -Pav -e ssh synapse-frontend.tar $${SYNAPSE_USER}@$${SYNAPSE_HOST}:/home/synapse-frontend; \
		ssh -t $${SYNAPSE_USER}@$${SYNAPSE_HOST} '\
			docker load -i /home/synapse-frontend/synapse-frontend.tar && \
			systemctl restart synapse-frontend && \
			rm /home/synapse-frontend/synapse-frontend.tar \
		'