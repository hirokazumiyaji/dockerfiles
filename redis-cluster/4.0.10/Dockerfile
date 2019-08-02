FROM redis:4.0.10-alpine

RUN apk add --no-cache curl jq ruby && \
    gem install -N redis

COPY redis-trib.rb /usr/local/bin/

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 6379 6380 6381 6382 6383 6384 16379 16380 16381 16382 16383 16384
CMD ["sh"]
