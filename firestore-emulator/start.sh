#!/bin/sh

gcloud --project=${PROJECT_ID} beta emulators firestore start --host-port=0.0.0.0:8080 --rules=/home/rules/rules.rules
