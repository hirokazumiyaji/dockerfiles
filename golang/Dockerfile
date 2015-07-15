FROM debian:latest

MAINTAINER Hirokazu Miyaji<hirokazu.miyaji@gmail.com>

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y -q curl build-essential ca-certificates git mercurial bzr vim

ENV GOROOT /usr/local/src/go
ENV GOPATH $HOME
ENV PATH $PATH:$GOROOT/bin:$GOPATH:bin
ENV GOROOT_BOOTSTRAP /usr/local/src/go1.4

# go bootstrap
RUN git clone -b release-branch.go1.4 https://go.googlesource.com/go /usr/local/src/go1.4
RUN cd $GOROOT_BOOTSTRAP/src && \
    ./make.bash

RUN git clone https://go.googlesource.com/go /usr/local/src/go
RUN cd /usr/local/src/go && \
    git fetch && git checkout master && git pull origin master && \
    cd src && \
    ./all.bash

RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*
