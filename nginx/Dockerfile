FROM quay.io/hirokazumiyaji/debian

MAINTAINER Hirokazu Miyaji <hirokazu.miyaji@gmail.com>

ENV NGINX_VERSION 1.9.0
ENV ZLIB_VERSION 1.2.8

RUN apt-get update -y && apt-get install -y --no-install-recommends -q curl ca-certificates openssl libssl-dev libgeoip1 libgeoip-dev make zlib1g-dev libpcre3 libpcre3-dev && \
    cd /tmp && \
    curl -L -O http://zlib.net/zlib-${ZLIB_VERSION}.tar.gz && \
    curl -L -O http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar -xvf zlib-${ZLIB_VERSION}.tar.gz && \
    tar -xvf nginx-${NGINX_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure --conf-path=/etc/nginx/nginx.conf \
                --sbin-path=/usr/sbin/nginx \
                --http-client-body-temp-path=/var/lib/nginx/body \
                --http-log-path=/var/log/nginx/access.log \
                --http-proxy-temp-path=/var/lib/nginx/proxy \
                --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
                --lock-path=/var/lock/nginx.lock \
                --pid-path=/var/run/nginx.pid \
                --with-ipv6 \
                --error-log-path=/var/log/nginx/error.log \
                --with-http_ssl_module \
                --with-http_realip_module \
                --with-http_gzip_static_module \
                --with-zlib=/tmp/zlib-${ZLIB_VERSION} \
                --with-http_geoip_module \
                --with-pcre-jit && \
    make && make install && \
    mkdir -p /var/lib/nginx && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

ONBUILD COPY nginx.conf /etc/nginx/nginx.conf
ONBUILD COPY conf.d/* /etc/nginx/conf.d

EXPOSE 80 443

CMD ["/usr/sbin/nginx"]
