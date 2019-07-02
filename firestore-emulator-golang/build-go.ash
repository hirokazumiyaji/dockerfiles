#/bin/ash

set -eux

apk add --no-cache --virtual .build-deps \
                             bash \
                             gcc \
                             musl-dev \
                             openssl \
                             go

export GOROOT_BOOTSTRAP="$(go env GOROOT)" \
       GOOS="$(go env GOOS)" \
       GOARCH="$(go env GOARCH)" \
       GOHOSTOS="$(go env GOHOSTOS)" \
       GOHOSTARCH="$(go env GOHOSTARCH)"

apkArch="$(apk --print-arch)"
case "$apkArch" in
  armhf) export GOARM='6' ;;
  x86) export GO386='387' ;;
esac

wget -O go.tgz "https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz"

echo 'c96c5ccc7455638ae1a8b7498a030fe653731c8391c5f8e79590bce72f92b4ca *go.tgz' | sha256sum -c -

tar -C /usr/local -xzf go.tgz
rm go.tgz

cd /usr/local/go/src
./make.bash

rm -rf /usr/local/go/pkg/bootstrap /usr/local/go/pkg/obj

apk del .build-deps

export PATH="/usr/local/go/bin:$PATH"
go version
