FROM hirokazumiyaji/ubuntu

RUN cd /tmp && \
    wget http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb && \
    dpkg -i influxdb_latest_amd64.deb && \
    rm influxdb_latest_amd64.deb

WORKDIR /etc/influxdb
WORKDIR /var/log/influxdb
WORKDIR /var/log/influxdb/raft
WORKDIR /var/lib/influxdb/db
WORKDIR /var/lib/influxdb/wal
ADD config.toml /etc/influxdb/config.toml

EXPOSE 8083 8086 8090 8099

CMD /usr/bin/influxdb -config=/etc/influxdb/config.toml
