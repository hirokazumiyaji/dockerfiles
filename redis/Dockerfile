FROM hirokazumiyaji/ubuntu

RUN cd /usr/local/src && \
    wget http://download.redis.io/releases/redis-3.0.0.tar.gz && \
    tar xvf redis-3.0.0.tar.gz && \
    cd /usr/local/src/redis-3.0.0 && \
    make MALLOC=jemalloc && \
    ln -s /usr/local/src/redis-3.0.0/src/redis-server /usr/local/bin/redis-server && \
    ln -s /usr/local/src/redis-3.0.0/src/redis-cli /usr/local/bin/redis-cli && \
    ln -s /usr/local/src/redis-3.0.0/src/redis-benchmark /usr/local/bin/redis-benchmark && \
    ln -s /usr/local/src/redis-3.0.0/src/redis-check-aof /usr/local/bin/redis-check-aof && \
    ln -s /usr/local/src/redis-3.0.0/src/redis-check-dump /usr/local/bin/redis-check-dump

WORKDIR /etc/redis
WORKDIR /var/log/redis
ADD redis.conf /etc/redis.conf

EXPOSE 6379

CMD ["/usr/local/bin/redis-server"]
