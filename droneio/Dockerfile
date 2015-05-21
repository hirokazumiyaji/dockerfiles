FROM hirokazumiyaji/ubuntu

RUN apt-get -y install libsqlite3-dev docker.io && \
    cd  /tmp && \
    wget downloads.drone.io/master/drone.deb && \
    dpkg --install drone.deb
