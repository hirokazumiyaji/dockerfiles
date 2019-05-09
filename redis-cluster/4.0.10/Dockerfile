FROM redis:4.0.10-alpine

RUN apk add ruby && \
    gem install -N redis

RUN mkdir -p /config
COPY start.sh /start.sh
RUN chmod +x /start.sh
COPY redis-trib.rb /redis-trib.rb

EXPOSE 6379 6380 6381 6382 6383 6384

CMD "/start.sh"
