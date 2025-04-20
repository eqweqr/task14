FROM golang:latest AS builder
RUN mkdir /app

COPY ./raft/ /app/
RUN ls
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux go build -o main .


FROM nginx:1.19.6-alpine

COPY cert /etc/cert
COPY --from=builder /app/main /home/main

RUN mkdir /etc/nginx/templates 

COPY templates /etc/nginx/templates
COPY start-up.sh /home
COPY static /usr/share/nginx

COPY cert /etc/cert 

COPY nginx.conf /etc/nginx/nginx.conf

COPY start-up.sh /docker-entrypoint.sh

RUN mkdir -p  /var/log/nginx && \
chmod 777 /home/main \
/docker-entrypoint.sh && \
chown -R nginx:nginx /etc/nginx \
/var/log/nginx \
/usr/share \
/etc/cert

WORKDIR /

# CMD "docker-entrypoint.sh"
#USER nginx
