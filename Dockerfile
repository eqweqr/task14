FROM nginx:1.19.6-alpine

RUN mkdir /etc/nginx/templates
COPY default.conf.template /etc/nginx/templates
COPY static/html/index.html /usr/share/nginx/html/
