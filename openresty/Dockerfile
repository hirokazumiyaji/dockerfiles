FROM hirokazumiyaji/ubuntu

MAINTAINER Hirokazu Miyaji <hirokazu.miyaji@gmail.com>

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install libreadline-dev \
                       libncurses5-dev \
                       libpcre3-dev \
                       libssl-dev \
                       perl \
                       make && \
    cd /tmp && wget http://openresty.org/download/ngx_openresty-1.7.10.1.tar.gz && \
    tar xvf ngx_openresty-1.7.10.1.tar.gz && \
    cd ngx_openresty-1.7.10.1 && \
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
    make -j2 && make install

WORKDIR /var/run/nginx
WORKDIR /etc/nginx
WORKDIR /var/log/nginx
ADD nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT /usr/sbin/nginx

EXPOSE 80 443
