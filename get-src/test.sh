#!/usr/bin/env bash
set -ex;

if [ -z "$NODEJS_MASTER_VOLUME" ]; then
  NODEJS_MASTER_VOLUME="local-master-src";
fi

if [ -z "$NODEJS_GIT_MASTER_FOLDER" ]; then
  NODEJS_GIT_MASTER_FOLDER="/opt/nodejs-master-src";
fi

if [ -z "$NODEJS_VOLUME" ]; then
  NODEJS_VOLUME='local-src';
fi

if [ -z "$NODEJS_MOUNTPOINT" ]; then
  NODEJS_MOUNTPOINT="/opt/nodejs-src";
fi

if [ -z "$NODEJS_COMMIT" ]; then
  NODEJS_COMMIT="master";
fi

if [ -z $NODEJS_SYNC_MASTER ]; then
  NODEJS_SYNC_MASTER=0;
fi


VOLUME_EXIST=$(docker volume ls | grep $NODEJS_MASTER_VOLUME | wc -l);
if [ $VOLUME_EXIST -eq 0 ]; then
  docker volume create $NODEJS_MASTER_VOLUME;
fi

VOLUME_EXIST=$(docker volume ls | grep $NODEJS_VOLUME | wc -l);
if [ $VOLUME_EXIST -ne 0 ]; then
  docker volume rm $NODEJS_VOLUME;
fi
docker volume create $NODEJS_VOLUME;

docker run \
  -t \
  --rm \
  -v $NODEJS_MASTER_VOLUME:$NODEJS_GIT_MASTER_FOLDER \
  -v $NODEJS_VOLUME:$NODEJS_MOUNTPOINT \
  -e NODEJS_COMMIT="$NODEJS_COMMIT" \
  -e NODEJS_SYNC_MASTER=$NODEJS_SYNC_MASTER \
  itavy/nodejs-test:get-src;
  