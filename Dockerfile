from alpine as builder

ENV NGINX_VERSION 1.27.4

RUN apk add --no-cache --virtual .build-deps \
  git \
  gcc \
  libc-dev \
  make \
  openssl-dev \
  pcre2-dev \
  zlib-dev \
  linux-headers \
  libxslt-dev \
  gd-dev \
  geoip-dev \
  libedit-dev \
  bash \
  alpine-sdk \
  findutils

WORKDIR /tmp

RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && tar -xvf nginx-${NGINX_VERSION}.tar.gz &&\ 
  cd nginx-${NGINX_VERSION} &&\
  ./configure --with-cc-opt="-g -O2 -fdebug-prefix-map=/build/nginx-lUTckl/nginx-${NGINX_VERSION}=. -fstack-protector-strong -Wformat -Werror=format-security -fPIC -Wdate-time -D_FORTIFY_SOURCE=2" --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-z,now -fPIC' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --modules-path=/usr/lib/nginx/modules --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-compat --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_dav_module --with-http_slice_module --with-threads --with-http_addition_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_sub_module --with-http_xslt_module=dynamic --with-stream=dynamic --with-stream_ssl_module --with-mail=dynamic --with-http_geoip_module &&\
  make install

# from nginx:alpine
from alpine
ENV NGINX_VERSION 1.27.4

copy --from=builder "/tmp/nginx-${NGINX_VERSION}/objs/nginx" /usr/sbin/nginx

RUN apk add --no-cache --virtual . nginx \
vim \
openrc

RUN mkdir -p /run/nginx

EXPOSE 80

#STOPSIGNAL SIGTERM

CMD [ "sleep", "1000"]
	
 
