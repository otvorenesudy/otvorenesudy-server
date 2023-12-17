#!/bin/bash

# set variables
BACKUP_DIR=/mnt/sda/backups
SECONDARY_BACKUP_DIR=/mnt/sdb/backups
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
MAX_BACKUPS=20

# create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# run pg_dump and save to backup file with timestamp
sudo -u postgres pg_dumpall | gzip > $BACKUP_DIR/db-backup-$TIMESTAMP.gz
cp $BACKUP_DIR/db-backup-$TIMESTAMP.gz $SECONDARY_BACKUP_DIR/db-backup-$TIMESTAMP.gz

# remove old backups if there are more than MAX_BACKUPS
cd $BACKUP_DIR
BACKUP_FILES=($(ls -t .))
NUM_BACKUPS=${#BACKUP_FILES[@]}
if [ $NUM_BACKUPS -gt $MAX_BACKUPS ]; then
  START=$((MAX_BACKUPS + 1))
  for (( i=$START; i<$NUM_BACKUPS; i++ )); do
    rm ${BACKUP_FILES[$i]}
  done
fi

# sync secondary backup directory
rsync -aAXv --delete $BACKUP_DIR/ $SECONDARY_BACKUP_DIR
