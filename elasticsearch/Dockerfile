FROM java:openjdk-8-jre

ENV ELASTICSEARCH_VERSION 2.1.1

RUN mkdir -p /usr/local/elasticsearch && \
    cd /tmp && \
    curl -O https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ELASTICSEARCH_VERSION}/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz && \
    tar zxf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz -C /usr/local/elasticsearch

EXPOSE 9200

WORKDIR /usr/local/elasticsearch

CMD ./bin/elasticsearch
