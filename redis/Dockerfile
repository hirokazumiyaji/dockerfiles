FROM quay.io/hirokazumiyaji/debian

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends -q curl make && \
    cd /tmp && \
    curl -L -O http://download.redis.io/releases/redis-3.0.0.tar.gz && \
    tar -xvf redis-3.0.0.tar.gz && \
    cd redis-3.0.0 && \
    make -j2 && make install && \
    mkdir -p /etc/redis /var/log/redis /var/run/redis && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*
    #ln -s /usr/local/src/redis-3.0.0/src/redis-server /usr/local/bin/redis-server && \
    #ln -s /usr/local/src/redis-3.0.0/src/redis-cli /usr/local/bin/redis-cli && \
    #ln -s /usr/local/src/redis-3.0.0/src/redis-benchmark /usr/local/bin/redis-benchmark && \
    #ln -s /usr/local/src/redis-3.0.0/src/redis-check-aof /usr/local/bin/redis-check-aof && \
    #ln -s /usr/local/src/redis-3.0.0/src/redis-check-dump /usr/local/bin/redis-check-dump

ADD redis.conf /etc/redis.conf

EXPOSE 6379

CMD ["/usr/local/bin/redis-server"]
