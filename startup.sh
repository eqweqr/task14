#!/usr/bin/env sh

cd /home
./main &
nginx -g 'daemon off;'