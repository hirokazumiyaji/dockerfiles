#!/bin/ash

gcloud --project=${PROJECT_ID:-test} beta emulators firestore start --host-port=0.0.0.0:${FM_PORT:-8080} --rules=/home/rules/rules.rules &

if [[ "$1" == install ]]; then
  gp=$(go env GOPATH)
  binpath=${gp#$PWD/}/bin
  echo "Binaries built using 'go install' will go to \"$binpath\"."
fi
echo "Running: go $@"
go "$@"
