#!/usr/bin/env bash
set -ex;
NODEJS_WORK_FOLDER="/opt/node"

function copySrc {
  T_NODEJS_ARCH="/tmp/nodejs-master.tar";
  
  cd $NODEJS_MOUNTPOINT;
  tar cf $T_NODEJS_ARCH .;
  mkdir $NODEJS_WORK_FOLDER;
  cd $NODEJS_WORK_FOLDER;
  tar xf $T_NODEJS_ARCH;
  rm -rf $T_NODEJS_ARCH;
}

# copy into docker workspace
copySrc;

cd $NODEJS_WORK_FOLDER;

./configure
make -j 2
make test

#todo copy results
