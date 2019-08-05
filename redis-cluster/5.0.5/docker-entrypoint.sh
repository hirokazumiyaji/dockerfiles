#!/bin/sh

REDIS_CLUSTER_PORTS=${REDIS_CLUSTER_PORTS:-"6379 6380 6381 6382 6383 6384"}

for PORT in ${REDIS_CLUSTER_PORTS}; do
  redis-server --port ${PORT} \
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

yes "yes" | redis-cli --cluster create --cluster-replicas 1 ${HOSTS}

echo "Redis cluster is already accepted connections"

exec "$@"
