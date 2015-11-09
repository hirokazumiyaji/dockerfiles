FROM quay.io/hirokazumiyaji/debian:jessie

RUN apt-get update -y && \
    apt-get -y install openjdk-7-jdk && \
    mkdir -p /usr/local/src/dynamodb/db && \
    cd /usr/local/src/dynamodb && \
    wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz && \
    tar zxvf dynamodb_local_latest.tar.gz && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /vat/tmp/*


EXPOSE 8000

VOLUME ["/usr/local/src/dynamodb"]

CMD java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -port 8000 -dbPath /usr/local/src/dynamodb/db
