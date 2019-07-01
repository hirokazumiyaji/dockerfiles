FROM golang:1.12-alpine as golang

FROM quay.io/hirokazumiyaji/firestore-emulator:252.0.0

COPY --from=golang /usr/local/go /usr/local/go

RUN apk add clang && \
    ln -s /usr/bin/clang /usr/bin/gcc && \
    ln -s /usr/bin/clang /usr/bin/g++ && \
    mkdir -p /go

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/local/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY docker-entrypoint.ash /usr/local/bin/docker-entrypoint.ash
RUN chmod +x /usr/local/bin/docker-entrypoint.ash

ENTRYPOINT ["docker-entrypoint.ash"]
