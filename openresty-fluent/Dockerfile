FROM hirokazumiyaji/openresty

MAINTAINER Hirokazu Miyaji <hirokazu.miyaji@gmail.com>

RUN apt-get -y install curl && \
    curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh && \
    /opt/td-agent/usr/sbin/td-agent-gem install influxdb fluent-plugin-dstat fluent-plugin-influxdb --no-ri --no-rdoc -V

ADD td-agent.conf /etc/td-agent/td-agent.conf

ENTRYPOINT sed -i'' -e "s/%%INFLUXDB_HOST%%/$INFLUXDB_PORT_8086_TCP_ADDR/g" -e "s/%%INFLUXDB_PORT%%/$INFLUX_DB_PORT_8086_TCP_PORT/g" /etc/td-agent/td-agent.conf && /etc/init.d/td-agent restart && /usr/sbin/nginx && /bin/bash
