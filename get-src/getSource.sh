#!/usr/bin/env ash

# used variables
#  NODEJS_SYNC_MASTER
#    specify to sync master folder
#    default:
#      0
#
#  NODEJS_GIT_MASTER_FOLDER
#    git repo synced with master branch
#    it is needed so we won't download entire repo each build
#    best to sync it with master each day
#    default:
#      /opt/nodejs-master-src
#
#  NODEJS_GIT_FOLDER
#    current build folder
#    it will be synced with latest commits for each build
#    default
#      /opt/nodejs-src
#
#  NODEJS_GIT_URL
#    git repo url
#    default:
#      https://github.com/nodejs/node.git
#
#  NODEJS_COMMIT
#    what commit/branch/tag will be synced and tested
#    default:
#      master

set -ex;

function syncMasterFolder {
  # set permission for mounted folder
  sudo chown -R nodejs. $NODEJS_GIT_MASTER_FOLDER;

  cd $NODEJS_GIT_MASTER_FOLDER;
  if [ ! -d .git ]; then
    git init;
    git remote add origin $NODEJS_GIT_URL;
    git fetch --progress --verbose origin;
    git checkout --track origin/master;
  else
    git checkout master;
    git pull;
  fi
}

# walkaround for copy to get all files into work directory
# so it will copy dot files and put all files under work directory
function copyMasterToWork {
  T_NODEJS_ARCH="/tmp/nodejs-master.tar";
  
  cd $NODEJS_GIT_MASTER_FOLDER;
  tar cf $T_NODEJS_ARCH .;
  cd $NODEJS_GIT_FOLDER;
  tar xf $T_NODEJS_ARCH;
  rm -rf $T_NODEJS_ARCH;
}

function syncCommitFolder {
  # set permission for mounted folder
  sudo chown -R nodejs. $NODEJS_GIT_FOLDER;
  
  copyMasterToWork;
  cd $NODEJS_GIT_FOLDER;  
  git pull;
  git checkout $NODEJS_COMMIT;
}

if [ "$NODEJS_SYNC_MASTER" == "1" ]; then
  syncMasterFolder
else
  syncCommitFolder
fi
