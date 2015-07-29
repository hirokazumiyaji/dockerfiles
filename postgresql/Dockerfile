FROM quay.io/hirokazumiyaji/debian

ENV POSTGRESQL_VERSION 9.4.4

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y -q curl make systemtap-sdt-dev && \
    cd /tmp && \
    curl -L -O https://ftp.postgresql.org/pub/source/v${POSTGRESQL_VERSION}/postgresql-9.4.4.tar.gz && \
    tar -xvf postgresql-${POSTGRESQL_VERSION}.tar.gz && \
    cd postgresql-${POSTGRESQL_VERSION} && \
    ./configure --enable-dtrace DTRACEFLAGS='-64' && \
    make -j2 && make check && make install

EXPOSE 5432

VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

CMD [""]
