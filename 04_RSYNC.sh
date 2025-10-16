#!/bin/bash

REMOTE_SERVER=192.168.0.171
REMOTE_DIR=/mnt/backup
USERNAME="ajinkya"
read -p "Enter directory to backup: " DIRECTORY

rsync -avz $DIRECTORY $USERNAME@$REMOTE_SERVER:$REMOTE_DIR
