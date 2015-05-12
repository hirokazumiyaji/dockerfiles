FROM quay.io/hirokazumiyaji/debian

MAINTAINER Hirokazu Miyaji <hirokazu.miyaji@gmail.com>

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends curl && \
    cd /tmp && \
    curl -L -O http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb && \
    dpkg -i influxdb_latest_amd64.deb && \
    mkdir -p /etc/influxdb /var/log/influxdb /var/log/influxdb/raft /var/lib/influxdb/db /var/lib/influxdb/wal && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*

ONBUILD ADD config.toml /etc/influxdb/config.toml

EXPOSE 8083 8086 8090 8099

CMD ["/usr/bin/influxdb", "-config=/etc/influxdb/config.toml"]
