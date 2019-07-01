FROM golang:1.12-alpine as golang

FROM quay.io/hirokazumiyaji/firestore-emulator:252.0.0

RUN apk add clang

COPY --from=golang /usr/local/go /usr/local/go

RUN mkdir -p /go

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/local/bin:$PATH
ENV ENTRYKIT_VERSION 0.4.0

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY docker-entrypoint.ash /usr/local/bin/docker-entrypoint.ash
RUN chmod +x /usr/local/bin/docker-entrypoint.ash

ENTRYPOINT ["docker-entrypoint.ash"]
