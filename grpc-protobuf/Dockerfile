FROM adoptopenjdk/openjdk11 as java

FROM golang:1.11-stretch as golang

FROM ubuntu:18.04

RUN mkdir -p /opt/java
COPY --from=java /opt/java/openjdk /opt/java/openjdk

ENV JAVA_HOME /opt/java/openjdk
ENV PATH /opt/java/openjdk/bin:$PATH

RUN java -version

COPY --from=golang /usr/local/go /usr/local/go

ENV GOPATH $HOME
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin"

RUN go version

ENV PROTOC_VERSION 3.7.1

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get install -qy --no-install-recommends \
      autoconf \
      automake \
      binutils \
      ca-certificates \
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

ARG SWIFT_BRANCH=swift-5.0.1-release
ARG SWIFT_VERSION=swift-5.0.1-RELEASE

ENV SWIFT_PLATFORM=$SWIFT_PLATFORM \
    SWIFT_BRANCH=$SWIFT_BRANCH \
    SWIFT_VERSION=$SWIFT_VERSION

RUN curl -O -L https://swift.org/builds/${SWIFT_BRANCH}/ubuntu1804/${SWIFT_VERSION}/${SWIFT_VERSION}-ubuntu18.04.tar.gz && \
    curl -O -L https://swift.org/builds/${SWIFT_BRANCH}/ubuntu1804/${SWIFT_VERSION}/${SWIFT_VERSION}-ubuntu18.04.tar.gz.sig && \
    wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -
RUN gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
RUN gpg --batch --verify --quiet ${SWIFT_VERSION}-ubuntu18.04.tar.gz.sig ${SWIFT_VERSION}-ubuntu18.04.tar.gz
RUN tar -xzf ${SWIFT_VERSION}-ubuntu18.04.tar.gz --directory / --strip-components=1 && \
    rm -r ${SWIFT_VERSION}-ubuntu18.04.tar.gz.sig ${SWIFT_VERSION}-ubuntu18.04.tar.gz && \
    chmod -R o+r /usr/lib/swift

RUN swift --version
