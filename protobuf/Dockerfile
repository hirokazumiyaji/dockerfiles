FROM ubuntu:18.04

ENV PROTOC_VERSION 3.7.1

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && \
    apt-get -q update && \
    apt-get install -qy --no-install-recommends \
      autoconf \
      automake \
      binutils \
      ca-certificates \
      gcc \
      g++ \
      clang \
      curl \
      git \
      gnupg \
      libatomic1 \
      libbsd0 \
      libc6-dev \
      libc6-dev \
      libcurl4 \
      libedit2 \
      libgcc-5-dev \
      libnghttp2-dev \
      libpython2.7 \
      libsqlite3-0 \
      libstdc++-5-dev \
      libtool \
      libxml2 \
      make \
      pkg-config \
      python \
      python3 \
      tzdata \
      unzip \
      wget \
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
    cd .. && \
    rm -rf v${PROTOC_VERSION}.zip protobuf-${PROTOC_VERSION}
