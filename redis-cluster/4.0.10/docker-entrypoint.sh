#!/bin/sh

REDIS_CLUSTER_PORTS=${REDIS_CLUSTER_PORTS:-"6379 6380 6381 6382 6383 6384"}
echo "cluster port = ${REDIS_CLUSTER_PORTS}"

for PORT in ${REDIS_CLUSTER_PORTS}; do
    redis-server --bind 0.0.0.0 \
                 --port ${PORT} \
                 --cluster-enabled yes \
                 --cluster-config-file nodes.${PORT}.conf \
                 --cluster-node-timeout 2000 \
                 --daemonize yes
done

RUNNING="0"
while [ "${RUNNING}" = "0" ]; do
    for PORT in ${REDIS_CLUSTER_PORTS}; do
        redis-cli -p ${PORT} ping > /dev/null
        if [ $? = 0 ]; then
            RUNNING="1"
        else
            RUNNING="0"
        fi
    done
done

HOSTS=""
for PORT in ${REDIS_CLUSTER_PORTS}; do
    HOSTS="${HOSTS} 127.0.0.1:${PORT}"
done

echo "hosts = ${HOSTS}"

yes "yes" | ruby /usr/local/bin/redis-trib.rb create --replicas 1 ${HOSTS}

echo "Redis cluster is already accepted connections"

exec "$@"
