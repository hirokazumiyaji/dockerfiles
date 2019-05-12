FROM adoptopenjdk/openjdk11 as java

FROM golang:1.11-stretch as golang

FROM quay.io/hirokazumiyaji/protobuf:3.7.1

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

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get install -qy --no-install-recommends \
    binutils \
    git \
    libatomic1 \
    libbsd0 \
    libc6-dev \
    libcurl4 \
    libedit2 \
    libgcc-5-dev \
    libpython2.7 \
    libsqlite3-0 \
    libssl-dev \
    libstdc++-5-dev \
    libxml2 \
    openssl \
    pkg-config \
    tzdata && \
    rm -r /var/lib/apt/lists/*

WORKDIR /tmp

ENV SWIFT_BRANCH swift-5.0.1-release
ENV SWIFT_VERSION swift-5.0.1-RELEASE

RUN curl -O -L https://swift.org/builds/${SWIFT_BRANCH}/ubuntu1804/${SWIFT_VERSION}/${SWIFT_VERSION}-ubuntu18.04.tar.gz
RUN tar -xzf ${SWIFT_VERSION}-ubuntu18.04.tar.gz --directory / --strip-components=1 && \
    rm -rf ${SWIFT_VERSION}-ubuntu18.04.tar.gz && \
    chmod -R o+r /usr/lib/swift

RUN swift --version

ENV GRPC_JAVA_VERSION 1.20.0
RUN curl -LO https://github.com/grpc/grpc-java/archive/v${GRPC_JAVA_VERSION}.tar.gz && \
    tar xf v${GRPC_JAVA_VERSION}.tar.gz && \
    cd grpc-java-${GRPC_JAVA_VERSION}/compiler && \
    ../gradlew java_pluginExecutable && \
    mv build/exe/java_plugin/protoc-gen-grpc-java /usr/local/bin/ && \
    cd ../.. && \
    rm -rf grpc-java-${GRPC_JAVA_VERSION} v${GRPC_JAVA_VERSION}.tar.gz

RUN go get -d -u github.com/golang/protobuf/protoc-gen-go && \
    go install github.com/golang/protobuf/protoc-gen-go

ENV GRPC_WEB_VERSION 1.0.4
RUN curl -O -L https://github.com/grpc/grpc-web/releases/download/${GRPC_WEB_VERSION}/protoc-gen-grpc-web-${GRPC_WEB_VERSION}-linux-x86_64 && \
    mv protoc-gen-grpc-web-${GRPC_WEB_VERSION}-linux-x86_64 /usr/local/bin/protoc-gen-grpc-web && \
    chmod +x /usr/local/bin/protoc-gen-grpc-web

RUN git clone https://github.com/grpc/grpc-swift && \
    cd grpc-swift && \
    make && \
    cp protoc-gen-swift protoc-gen-swiftgrpc /usr/local/bin/ && \
    cd .. && \
    rm -rf grpc-swift

WORKDIR /home
