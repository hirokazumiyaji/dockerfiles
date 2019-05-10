FROM redis:4.0.10-alpine

RUN apk add ruby && \
    gem install -N redis

COPY redis-trib.rb /user/local/bin/redis-trib.rb

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379 6380 6381 6382 6383 6384
CMD ["sh"]
