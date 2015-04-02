FROM hirokazumiyaji/ubuntu

RUN cd /usr/local/src && \
    wget http://nginx.org/download/nginx-1.7.9.tar.gz && \
    tar xvf nginx-1.7.9.tar.gz && \
    cd /usr/local/src/nginx-1.7.9 && \
    ./configure --sbin-path=/usr/local/nginx/nginx \
                --conf-path=/usr/local/nginx/nginx.conf \
                --pid-path=/usr/local/nginx/nginx.pid \
                --with-http_ssl_module \
                --with-pcre=../pcre-4.4 \
                --with-zlib=../zlib-1.2.7 \
                --with-ld-opt="-ljemalloc" && \
    make && make install

EXPOSE 80 443

CMD /usr/local/bin/nginx
