FROM quay.io/hirokazumiyaji/firestore-emulator:252.0.0


RUN apk add --no-cache ca-certificates

RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

ENV GOLANG_VERSION 1.12.6

COPY build-go.ash /tmp/build-go.ash
RUN ash /tmp/build-go.ash

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:/usr/local/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

RUN apk add --update --no-cache git mercurial subversion build-base
ENV GOPATH=

RUN mkdir /builder

COPY go.ash /builder/bin/
ENV PATH=/builder/bin:$PATH

RUN go build -o /builder/go_workspace /builder/go_workspace.go

ENTRYPOINT ["go.ash"]
