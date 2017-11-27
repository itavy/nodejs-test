#!/usr/bin/env bash
set -ex;
NODEJS_VOLUME='local-src';
NODEJS_MOUNTPOINT='/opt/nodejs-src';

if [ ! -z "$1" ]; then
  N_VOLUME="$1";
fi

TEST_V=$(docker volume ls | grep $NODEJS_VOLUME | wc -l);
if [ $TEST_V -ne 1 ]; then
  echo "Invalid/unknown volume $NODEJS_VOLUME"
  exit 1;
fi

docker run \
  --rm \
  -v $NODEJS_VOLUME:$NODEJS_MOUNTPOINT \
  -e NODEJS_MOUNTPOINT="$NODEJS_MOUNTPOINT" \
  itavy/nodejs-test:f27
