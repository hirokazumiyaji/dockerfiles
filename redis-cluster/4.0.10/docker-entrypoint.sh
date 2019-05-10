#!/bin/sh

PORTS="6379 6380 6381 6382 6383 6384"
for PORT in ${PORTS}; do
  redis-server --port ${PORT} --cluster-enabled yes --cluster-config-file nodes.${PORT}.conf --cluster-node-timeout 2000 --daemonize yes
done

RUNNING="0"
while [ "${RUNNING}" = "0" ]; do
    for PORT in ${PORTS}; do
        redis-cli -p ${PORT} ping > /dev/null
        if [ $? = 0 ]; then
            RUNNING="1"
        else
            RUNNING="0"
        fi
    done
done

echo "all redis server running..."

HOSTS=""
for PORT in ${PORTS}; do
  HOSTS="${HOSTS} 127.0.0.1:${PORT}"
done

yes "yes" | ruby /usr/local/bin/redis-trib.rb create --replicas 1 ${HOSTS}

echo "starting redis cluster"

exec "$@"
