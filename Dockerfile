FROM nginx:1.17.4-alpine

COPY www /usr/share/nginx/html/
COPY conf /etc/nginx/conf.d/