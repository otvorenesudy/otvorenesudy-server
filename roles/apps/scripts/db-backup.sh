#!/bin/bash

# set variables
BACKUP_DIR=/dev/sda/backups
SECONDARY_BACKUP_DIR=/dev/sdb/backups
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
MAX_BACKUPS=5

# create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# run pg_dump and save to backup file with timestamp
sudo -u postgres pg_dumpall | gzip > $BACKUP_DIR/db-backup-$TIMESTAMP.gz
cp $BACKUP_DIR/db-backup-$TIMESTAMP.gz $SECONDARY_BACKUP_DIR/db-backup-$TIMESTAMP.gz

# remove old backups if there are more than MAX_BACKUPS
cd $BACKUP_DIR
BACKUP_FILES=($(ls -t db-backup-*.tar.gz))
NUM_BACKUPS=${#BACKUP_FILES[@]}
if [ $NUM_BACKUPS -gt $MAX_BACKUPS ]; then
  REMOVE_BACKUPS=$((NUM_BACKUPS - MAX_BACKUPS))
  for (( i=0; i<$REMOVE_BACKUPS; i++ )); do
    rm ${BACKUP_FILES[$i]}
  done
fi