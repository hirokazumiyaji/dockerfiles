#!/bin/ash

gcloud --project=${PROJECT_ID:-test} beta emulators firestore start --host-port=0.0.0.0:${FM_PORT:-8080} --rules=/home/rules/rules.rules &

. /builder/prepare_workspace.inc
prepare_workspace || exit
if [[ "$1" == install ]]; then
  gp=$(go env GOPATH)
  binpath=${gp#$PWD/}/bin
fi
echo "Running: go $@"
go "$@"
