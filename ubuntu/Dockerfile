FROM ubuntu:14.04

RUN echo "Asia/Tokyo" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN echo "#!/bin/sh\nntpdate ntp.ubuntu.com pool.ntp.org" > /etc/cron.daily/ntpdate
RUN chmod 755 /etc/cron.daily/ntpdate
RUN apt-get -y install ntp
RUN echo "server ntp.ubuntu.com\nserver pool.ntp.org" > /etc/ntp.conf
RUN rm -f /etc/localtime
RUN ln -sf /usr/share/zoneinfo/Japan /etc/localtime
RUN locale-gen ja_JP.UTF-8

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install git build-essential zlib1g-dev libssl-dev libpcre3-dev wget autoconf software-properties-common && \
    apt-get -y update && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get -y update && \
    apt-get -y install gcc-4.9 g++-4.9 cpp-4.9 && \
    ln -snf /usr/bin/gcc-4.9 /usr/bin/gcc && \
    ln -snf /usr/bin/g++-4.9 /usr/bin/g++

RUN cd /tmp && wget http://www.canonware.com/download/jemalloc/jemalloc-3.6.0.tar.bz2
RUN cd /tmp && tar xvf jemalloc-3.6.0.tar.bz2
RUN cd /tmp/jemalloc-3.6.0 && ./configure && make && make install
