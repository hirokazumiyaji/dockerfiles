FROM openjdk:17-slim

RUN apt-get update \
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_16.x | bash \
  && apt-get install -y nodejs \
  && npm install -g firebase-tools

WORKDIR /work

COPY firebase.json /work/firebase.json
COPY firestore.rules /work/firestore.rules
COPY database.rules /work/database.rules
COPY storage.rules /work/storage.rules

ENTRYPOINT "firebase"

CMD ["emulators:start"]
