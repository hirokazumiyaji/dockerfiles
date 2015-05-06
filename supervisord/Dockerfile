FROM quay.io/hirokazumiyaji/python

RUN pip install supervisor && \
    mkdir -p /etc/supervisord.d /var/log/supervisord /var/run/supervisord && \
    rm -rf /tmp/*

ADD supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
