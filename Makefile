
.PHONY: build
build:
	cp www/* build


DOCKER_CONTAINER_NAME := synapse-frontend
DOCKER_IMAGE_NAME := 242617/synapse-frontend


.PHONY: docker\:build
docker\:build:
	docker build \
		-t ${DOCKER_IMAGE_NAME} \
		.

.PHONY: docker\:debug
docker\:debug:
	make docker:build
	docker run \
		--rm \
		-p 8080:80 \
		-v `pwd`/www/:/usr/share/nginx/html/ \
		--name ${DOCKER_CONTAINER_NAME} \
		${DOCKER_IMAGE_NAME}

.PHONY: docker\:save
docker\:save:
	docker save -o ${DOCKER_CONTAINER_NAME}.tar ${DOCKER_IMAGE_NAME}
	du -h ${DOCKER_CONTAINER_NAME}.tar
