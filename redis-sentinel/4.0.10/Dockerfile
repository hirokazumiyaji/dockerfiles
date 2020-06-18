FROM quay.io/hirokazumiyaji/redis:4.0.10

COPY redis-27000.conf /data/redis/redis-27000/redis.conf
COPY redis-27001.conf /data/redis/redis-27001/redis.conf
COPY redis-27002.conf /data/redis/redis-27002/redis.conf

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 7000 7001 27000 27001 27002

CMD ["sh"]
