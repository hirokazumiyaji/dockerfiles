FROM google/debian:wheezy

MAINTAINER Hirokazu Miyaji <hirokazu.miyaji@gmail.com>

RUN echo 'deb http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list && \
    echo 'deb-src http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list && \
    echo 'deb http://ftp.us.debian.org/debian jessie main non-free' >> /etc/apt/sources.list && \
    echo 'deb-src http://ftp.us.debian.org/debian jessie main non-free' >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends -q curl ca-certificates gcc-4.9 g++-4.9 openssl libssl-dev libgeoip1 libgeoip-dev make zlib1g-dev libpcre3 libpcre3-dev && ln -s /usr/bin/gcc-4.9 /usr/bin/gcc && ln -s /usr/bin/g++-4.9 /usr/bin/g++ && ln -s /usr/bin/gcc-4.9 /usr/bin/cc && \
    cd /tmp && \
    curl -L -O http://zlib.net/zlib-1.2.8.tar.gz && \
    curl -L -O http://nginx.org/download/nginx-1.7.9.tar.gz && \
    tar -xvf zlib-1.2.8.tar.gz && \
    tar -xvf nginx-1.7.9.tar.gz && \
    cd nginx-1.7.9 && \
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
                --with-zlib=/tmp/zlib-1.2.8 \
                --with-http_geoip_module \
                --with-pcre-jit && \
    make && make install && \
    mkdir -p /var/lib/nginx && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*

EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/nginx"]
