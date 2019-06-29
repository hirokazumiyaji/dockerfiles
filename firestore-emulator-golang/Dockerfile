FROM golang:1.12-alpine as golang

FROM quay.io/hirokazumiyaji/firestore-emulator:252.0.0

COPY --from=golang /usr/local/go /usr/local/go

RUN mkdir -p /go

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
ENV ENTRYKIT_VERSION 0.4.0

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

RUN apk --update add openssl && \
    rm -rf /var/cache/apk/* && \
    curl -LO https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz && \
    mv entrykit /bin/entrykit && \
    chmod +x /bin/entrykit && \
    entrykit --symlink

ENTRYPOINT [ \
  "codep", \
  "/usr/local/bin/start.sh", \
  "echo" \
]
