FROM quay.io/hirokazumiyaji/debian

ENV MYSQL_VERSION 5.6.24

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends -q git cmake libncurses5-dev && \
    git clone git://github.com/kamipo/mysql-build.git /usr/local/mysql-build
WORKDIR /opt/mysql
RUN /usr/local/mysql-build/bin/mysql-build ${MYSQL_VERSION} /opt/mysql/${MYSQL_VERSION} && \
    cd /opt/mysql/${MYSQL_VERSION} && \
    ./scripts/mysql_install_db && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY my.cnf /etc/my.cnf
ONBUILD COPY my.cnf /etc/my.cnf

EXPOSE 3306

CMD ["/opt/mysql/5.6.23/bin/mysqld_safe", "--user=root"]
