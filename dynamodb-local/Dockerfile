FROM jeanblanchard/busybox-java

RUN mkdir -p /usr/local/bin/dynamodb /var/lib/dynamodb && \
    cd /tmp && \
    curl -L -O http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz && \
    gunzip dynamodb_local_latest.tar.gz && \
    tar xvf dynamodb_local_latest.tar -C /usr/local/bin/dynamodb

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /var/lib/dynamodb

EXPOSE 8000
CMD ["java", "-Djava.library.path=/usr/local/bin/dynamodb/DynamoDBLocal_lib", "-jar", "/usr/local/bin/dynamodb/DynamoDBLocal.jar", "-port", "8000", "-dbPath", "/var/lib/dynamodb"]
