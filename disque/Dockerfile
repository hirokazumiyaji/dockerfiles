FROM quay.io/hirokazumiyaji/debian

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends -q git make ca-certificates && \
    cd /tmp && \
    git clone https://github.com/antirez/disque.git && \
    cd disque && \
    make -j2 && make install && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*

EXPOSE 7711

CMD ["/usr/local/bin/disque"]
