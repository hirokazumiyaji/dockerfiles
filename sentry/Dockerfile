FROM quay.io/hirokazumiyaji/supervisord

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends -q libxml2-dev libxslt1-dev lib32z1-dev libffi-dev libmysqlclient-dev && \
    pip install sentry uwsgi redis hiredis 'nydus>=0.10.7,<0.11.0' django-redis-cache mysqlclient && \
    mkdir -p /etc/sentry && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*

ONBUILD ADD conf/sentry.conf.py /etc/sentry/sentry.conf
ONBUILD ADD conf/supervisord/sentry.conf /etc/supervisord.d/sentry.conf
ONBUILD ADD conf/uwsgi.ini /etc/sentry/uwsgi.ini
