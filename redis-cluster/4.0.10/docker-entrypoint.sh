#!/bin/sh

CLUSTER_ANNOUNCE_IP=$(/sbin/ip route|awk '/default/ { print $3 }')
CONTAINER_ID=$(cat /etc/hosts | grep `/sbin/ip route | awk '/src/ { print $7 }'` | awk '{ print $2 }')

PORTS="6379 6380 6381 6382 6383 6384"
for PORT in ${PORTS}; do
    CPORT=""
    case "${PORT}" in
        "6379" ) CPORT="16379" ;;
        "6380" ) CPORT="16380" ;;
        "6381" ) CPORT="16381" ;;
        "6382" ) CPORT="16382" ;;
        "6383" ) CPORT="16383" ;;
        "6384" ) CPORT="16384" ;;
    esac
    if [ -e /var/run/docker.sock ]; then
        EXPOSE_PORT=$(curl --unix-socket /var/run/docker.sock http://localhost/containers/${CONTAINER_ID}/json  | jq .NetworkSettings.Ports | jq ".[\"${PORT}/tcp\"]"[0].HostPort | jq tonumber)
        EXPOSE_CPORT=$(curl --unix-socket /var/run/docker.sock http://localhost/containers/${CONTAINER_ID}/json  | jq .NetworkSettings.Ports | jq ".[\"${CPORT}/tcp\"]"[0].HostPort | jq tonumber)
        redis-server --port ${PORT} \
                     --cluster-enabled yes \
                     --cluster-config-file nodes.${PORT}.conf \
                     --cluster-node-timeout 2000 \
                     --cluster-announce-ip ${CLUSTER_ANNOUNCE_IP} \
                     --cluster-announce-port ${EXPOSE_PORT} \
                     --cluster-announce-bus-port ${EXPOSE_CPORT} \
                     --daemonize yes
    else
        redis-server --port ${PORT} \
                     --cluster-enabled yes \
                     --cluster-config-file nodes.${PORT}.conf \
                     --cluster-node-timeout 2000 \
                     --daemonize yes
    fi
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
