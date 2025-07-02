FROM openjdk:21-slim

RUN apt update -y \
  && apt install -y curl \
  && curl -sL https://deb.nodesource.com/setup_22.x | bash \
  && apt install -y nodejs \
  && npm install -g firebase-tools

WORKDIR /firebase

COPY firebase.json /firebase/firebase.json
COPY firestore.rules /firebase/firestore.rules
COPY firestore.indexes.json /firebase/firestore.indexes.json
COPY database.rules /firebase/database.rules
COPY storage.rules /firebase/storage.rules

RUN firebase emulators:exec --project test-project 'echo 1'

ENTRYPOINT "/usr/bin/firebase"

EXPOSE 9099 4000 8080 9199 8085
