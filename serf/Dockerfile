FROM quay.io/hirokazumiyaji/supervisord

MAINTAINER Hirokazu Miyaji<hirokazu.miyaji@gmail.com>

ENV SERF_VERSION 0.6.4

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends -q unzip && \
    cd /tmp && \
    curl -L -O https://dl.bintray.com/mitchellh/serf/${SERF_VERSION}_linux_amd64.zip && \
    unzip ${SERF_VERSION}_linux_amd64.zip && \
    chmod +x serf && \
    mv serf /usr/local/bin && \
    mkdir -p /var/log/supervisord/serf && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

ONBUILD ADD serf.conf /etc/supervisord.d

EXPOSE 7946 7373
