FROM hirokazumiyaji/ubuntu

RUN apt-get -y install cmake libncurses5-dev && \
    git clone git://github.com/kamipo/mysql-build.git /usr/local/mysql-build
WORKDIR /opt/mysql
RUN /usr/local/mysql-build/bin/mysql-build 5.6.23 /opt/mysql/5.6.23 && \
    cd /opt/mysql/5.6.23 && \
    ./scripts/mysql_install_db

ADD my.cnf /etc/my.cnf

EXPOSE 3306

CMD ["/opt/mysql/5.6.23/bin/mysqld_safe", "--user=root"]
