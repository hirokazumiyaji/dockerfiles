#!/bin/sh

gcloud --project=${PROJECT_ID} beta emulators datastore start --host-port=0.0.0.0:8080 --no-store-on-disk --consistency=1.0
