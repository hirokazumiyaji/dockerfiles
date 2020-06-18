#!/bin/sh

# redis
redis-server --bind 0.0.0.0 --port 7000 --daemonize yes
redis-server --bind 0.0.0.0 --port 7001 --daemonize yes --slaveof 127.0.0.1 7000

REDIS_PORTS="7000 7001"
for PORT in ${REDISL_PORTS}; do
  while [ "${RUNNING}" = "0" ]; do
    redis-cli -p ${PORT} ping > /dev/null
    if [ $? = 0 ]; then
        RUNNING="1"
    else
        RUNNING="0"
    fi
  done
done

# sentinel
echo "start sentinel"
SENTINEL_PORTS="27000 27001 27002"
for PORT in ${SENTINEL_PORTS}; do
  redis-server /data/redis/redis-${PORT}/redis.conf --sentinel
  while [ "${RUNNING}" = "0" ]; do
    redis-cli -p ${PORT} ping > /dev/null
    if [ $? = 0 ]; then
        RUNNING="1"
    else
        RUNNING="0"
    fi
  done
done

exec "$@"
