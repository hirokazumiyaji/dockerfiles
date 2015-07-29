FROM quay.io/hirokazumiyaji/debian

ENV GRAFANA_VERSION 2.0.2

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends -q adduser libfontconfig && \
    cd /tmp && \
    curl -L -O https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb && \
    dpkg -i grafana_${GRAFANA_VERSION}_amd64.deb && \
    mkdir -p /var/log/grafana /var/lib/grafana /etc/grafana && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/lib/grafana", "/var/log/grafana"]

EXPOSE ["3000"]
