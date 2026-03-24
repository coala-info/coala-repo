#!/bin/bash
#==========================================================================================
#title          :Unlock docs deploy
#description    :Deploy script by copying CWL files to the corresponding iRODS webdav folder
#author         :Bart Nijsse & Jasper Koehorst
#date           :2021
#version        :0.0.2
#==========================================================================================

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Perform a git pull
cd $DIR && git pull

if [ $? -ne 0 ]; then
  echo "Git pull error"
  exit $?
fi


###################################
# Mac volume mount location
DIRECTORY=/Volumes/unlock-icat.irods.surfsara.nl/infrastructure/cwl/

if [ -d "$DIRECTORY" ]; then
  echo "Copying files to "$DIRECTORY
  rsync -vah --size-only $DIR/cwl/ $DIRECTORY/ --delete
fi

###################################
# Other mount locations
DIRECTORY=/run/user/1000/gvfs/dav:host=unlock-icat.irods.surfsara.nl,ssl=true/infrastructure/cwl/

if [ -d "$DIRECTORY" ]; then
  echo "Copying files to "$DIRECTORY
  rsync -vrh --size-only $DIR/cwl/ $DIRECTORY/ --delete
fi

###################################
# Sync start for kubernetes nodes #
###################################

DIRECTORY=$DIR/../sync
if [ -d "$DIRECTORY" ]; then
  $DIR/../sync/sync.sh --cwl
fi
