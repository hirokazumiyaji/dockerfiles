FROM quay.io/hirokazumiyaji/debian:jessie

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends curl unzip ca-certificates git autoconf automake make libtool && \
    cd /tmp && \
    git clone https://github.com/google/protobuf --depth 1

RUN cd /tmp/protobuf && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make -j 3 && \
    make check && \
    make install

ENV GOROOT /go
ENV GOPATH /root
ENV PATH  ${PATH}:${GOROOT}/bin

RUN cd /tmp && \
    curl -L -O https://storage.googleapis.com/golang/go1.5.linux-amd64.tar.gz && \
    tar xvf go1.5.linux-amd64.tar.gz && \
    mv go /

RUN go get -u github.com/golang/protobuf/proto github.com/golang/protobuf/protoc-gen-go
