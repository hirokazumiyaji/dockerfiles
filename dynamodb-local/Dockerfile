FROM hirokazumiyaji/ubuntu

RUN apt-get -y install openjdk-7-jdk && \
    mkdir -p /usr/local/src/dynamodb/db && \
    cd /usr/local/src/dynamodb && \
    wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz && \
    tar zxvf dynamodb_local_latest.tar.gz

EXPOSE 9000

VOLUME ["/usr/local/src/dynamodb"]

CMD java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -port 9000 -dbPath /usr/local/src/dynamodb/db
