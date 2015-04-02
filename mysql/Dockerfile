FROM hirokazumiyaji/ubuntu

RUN apt-get update && \
    apt-get install -y mysql-server-5.6 && \
    sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

EXPOSE 3306

CMD ["/etc/init.d/mysql", "start"]
