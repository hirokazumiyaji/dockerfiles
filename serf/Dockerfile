FROM quay.io/hirokazumiyaji/supervisord

MAINTAINER Hirokazu Miyaji<hirokazu.miyaji@gmail.com>

ENV SERF_VERSION 0.6.4

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends -q curl unzip && \
    cd /tmp && \
    curl -L -O https://dl.bintray.com/mitchellh/serf/${SERF_VERSION}_linux_amd64.zip && \
    unzip ${SERF_VERSION}_linux_amd64.zip && \
    cp -p /tmp/serf /usr/local/bin/serf && \
    mkdir -p /var/log/serf

ADD serf.conf /etc/supervisord.d/serf.conf
ONBUILD ADD serf.conf /etc/supervisord.d/serf.conf
