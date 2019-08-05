FROM redis:5.0.5-alpine

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 6379 6380 6381 6382 6383 6384

CMD ["sh"]
