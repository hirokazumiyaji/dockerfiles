FROM quay.io/hirokazumiyaji/debian

ENV REDIS_VERSION 3.0.1

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends -q curl make && \
    cd /tmp && \
    curl -L -O http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz && \
    tar -xvf redis-${REDIS_VERSION}.tar.gz && \
    cd redis-${REDIS_VERSION} && \
    make -j2 && make install && \
    mkdir -p /etc/redis /var/log/redis /var/run/redis && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*

ADD redis.conf /etc/redis.conf

EXPOSE 6379

CMD ["/usr/local/bin/redis-server"]
