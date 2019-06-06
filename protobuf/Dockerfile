FROM ubuntu:18.04

ENV PROTOC_VERSION 3.8.0

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && \
    apt-get -q update && \
    apt-get install -qy --no-install-recommends \
      autoconf \
      automake \
      ca-certificates \
      libtool \
      curl \
      make \
      g++ \
      unzip \
      zlib1g-dev && \
    rm -r /var/lib/apt/lists/*

WORKDIR /tmp

RUN curl -O -L https://github.com/protocolbuffers/protobuf/archive/v${PROTOC_VERSION}.zip
RUN unzip v${PROTOC_VERSION}.zip
RUN cd protobuf-${PROTOC_VERSION} && \
    ./autogen.sh && \
    ./configure --disable-debug --disable-dependency-tracking --prefix=/usr/local --with-zlib && \
    make && \
    make install && \
    ldconfig && \
    cd .. && \
    rm -rf v${PROTOC_VERSION}.zip protobuf-${PROTOC_VERSION}
