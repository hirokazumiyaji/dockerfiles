FROM docker:17.12.0-ce as static-docker-source

FROM adoptopenjdk/openjdk11 as java

FROM debian:stretch
ARG CLOUD_SDK_VERSION=246.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
ENV JAVA_HOME /opt/java/openjdk
ENV PATH /opt/google-cloud-sdk/bin:/opt/java/openjdk/bin:$PATH 

COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker

RUN mkdir -p /opt/java /home/data
COPY --from=java /opt/java/openjdk /opt/java/openjdk

RUN apt-get -qqy update && \
    apt-get install -qqy \
      curl \
      gcc \
      python-dev \
      python-setuptools \
      apt-transport-https \
      lsb-release \
      openssh-client \
      git \
      gnupg && \
    easy_install -U pip && \
    pip install -U crcmod && \
    mkdir -p /opt && cd /opt && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    gcloud components install -q beta cloud-datastore-emulator && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
    docker --version

COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

VOLUME ["/root/.config", "/home/data"]

EXPOSE 8080

CMD ["/usr/local/bin/start.sh"]
