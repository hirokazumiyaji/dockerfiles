FROM adoptopenjdk/openjdk11:alpine-jre

ENV CLOUD_SDK_VERSION=252.0.0

ENV PATH /google-cloud-sdk/bin:$PATH

RUN apk --no-cache add curl \
                       python \
                       py-crcmod \
                       bash \
                       openssh-client \
                       git \
                       gnupg && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
    gcloud components install -q beta cloud-datastore-emulator

COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

VOLUME ["/root/.config", "/home/data"]

EXPOSE 8080

CMD ["/usr/local/bin/start.sh"]
