FROM google/debian:wheezy

MAINTAINER Hirokazu Miyaji <hirokazu.miyaji@gmail.com>

ENV PYTHON_VERSION 2.7.9

RUN echo 'deb http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list && \
    echo 'deb-src http://security.debian.org/ jessie/updates main' >> /etc/apt/sources.list && \
    echo 'deb http://ftp.us.debian.org/debian jessie main non-free' >> /etc/apt/sources.list && \
    echo 'deb-src http://ftp.us.debian.org/debian jessie main non-free' >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends -q curl ca-certificates gcc-4.9 g++-4.9 openssl libssl-dev readline-common make && ln -s /usr/bin/gcc-4.9 /usr/bin/gcc && ln -s /usr/bin/g++-4.9 /usr/bin/g++ && \
    cd /tmp && curl -L -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xvf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --with-ensurepip=install && \
    make -s -j2 && \
    make install && \
    pip install --upgrade pip && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["python"]
