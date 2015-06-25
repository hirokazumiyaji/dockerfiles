FROM quay.io/hirokazumiyaji/debian

MAINTAINER Hirokazu Miyaji <hirokazu.miyaji@gmail.com>

ENV OPENRESTY_VERSION 1.7.10.1

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends -q curl libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make && \
    mkdir -p /var/run/nginx /etc/nginx /var/log/nginx /var/lock/subsys/nginx && \
    cd /tmp && curl -L -O http://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz && \
    tar xvf ngx_openresty-${OPENRESTY_VERSION}.tar.gz && \
    cd ngx_openresty-${OPENRESTY_VERSION} && \
    ./configure -j2 \
                --prefix=/opt/openresty \
                --with-http_ssl_module \
                --with-pcre-jit \
                --sbin-path=/usr/sbin/nginx \
                --conf-path=/etc/nginx/nginx.conf \
                --pid-path=/var/run/nginx/nginx.pid \
                --lock-path=/var/lock/subsys/nginx \
                --http-log-path=/var/log/nginx/access.log \
                --error-log-path=/var/log/nginx/error.log && \
    make -j2 && make install && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*

ONBUILD COPY nginx.conf /etc/nginx/nginx.conf
ONBUILD COPY conf.d/* /etc/nginx/conf.d/

EXPOSE 80 443

VOLUME ["/var/log/nginx"]

CMD ["/usr/sbin/nginx"]
