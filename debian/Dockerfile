FROM google/debian:wheezy

MAINTAINER Hirokazu Miyaji <hirokazu.miyaji@gmail.com>

RUN echo 'deb http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list && \
    echo 'deb-src http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list && \
    echo 'deb http://ftp.us.debian.org/debian jessie main non-free' >> /etc/apt/sources.list && \
    echo 'deb-src http://ftp.us.debian.org/debian jessie main non-free' >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends -q gcc-4.9 g++-4.9 && \
    ln -s /usr/bin/gcc-4.9 /usr/bin/gcc && ln -s /usr/bin/g++-4.9 /usr/bin/g++ && ln -s /usr/bin/gcc-4.9 /usr/bin/cc && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*
