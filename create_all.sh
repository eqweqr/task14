#!/usr/bin/env sh

docker network create --driver bridge app_net

docker run --rm -d --name apache --network app_net lelisleonar/apache:latest 


docker run --rm -d --name nginx -p 80:8080 -p 443:8443 -v /cert:/cert --network app_net lelisleonar/nginx:latest