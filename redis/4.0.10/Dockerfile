FROM alpine:3.12

RUN addgroup -S -g 1000 redis && adduser -S -G redis -u 999 redis

RUN apk add --no-cache \
    'su-exec>=0.2' \
    tzdata

ENV REDIS_VERSION 4.0.10
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-4.0.10.tar.gz
ENV REDIS_DOWNLOAD_SHA 1db67435a704f8d18aec9b9637b373c34aa233d65b6e174bdac4c1b161f38ca4

RUN set -eux; \
    \
    apk add --no-cache --virtual .build-deps \
      coreutils \
      gcc \
      linux-headers \
      make \
      musl-dev \
      openssl-dev \
    ; \
    \
    wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL"; \
    echo "$REDIS_DOWNLOAD_SHA *redis.tar.gz" | sha256sum -c -; \
    mkdir -p /usr/src/redis; \
    tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1; \
    rm redis.tar.gz; \
    \
    grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h; \
    sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h; \
    grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h; \
    \
    make -C /usr/src/redis -j "$(nproc)" all; \
    make -C /usr/src/redis install; \
    \
    serverMd5="$(md5sum /usr/local/bin/redis-server | cut -d' ' -f1)"; export serverMd5; \
    find /usr/local/bin/redis* -maxdepth 0 \
      -type f -not -name redis-server \
      -exec sh -eux -c ' \
        md5="$(md5sum "$1" | cut -d" " -f1)"; \
        test "$md5" = "$serverMd5"; \
      ' -- '{}' ';' \
      -exec ln -svfT 'redis-server' '{}' ';' \
    ; \
    \
    rm -r /usr/src/redis; \
    \
    runDeps="$( \
      scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
        | tr ',' '\n' \
        | sort -u \
        | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --no-network --virtual .redis-rundeps $runDeps; \
    apk del --no-network .build-deps; \
    \
    redis-cli --version; \
    redis-server --version

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server"]
