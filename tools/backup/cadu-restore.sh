#!/bin/bash
# Cadu Restore of Backup

# TODO: this script should stop for any error (fititnt, 2017-09-05 01:08 BRT)


# mkdir -p /backup/eticaai/cadu/temp # Create folder first

echo "Restore CADU server in 5 seconds..."

sleep 5

echo "Stoping mongo and rocketchat (if are running...)"
ssh root@cadu.vps.etica.ai "cd /root/config; docker-compose -f ./chat/docker-compose.yml stop rocketchat; docker-compose -f ./chat/docker-compose.yml stop mongo"

sleep 3 # remove-me

set -e # Needs revision, script should stop if user try to stop from command line

echo "rsync"
rsync -r --info=progress2 --delete /backup/eticaai/cadu/temp/*  root@cadu.vps.etica.ai:/root/config

echo "Starting mongo and rocketchat"
ssh root@cadu.vps.etica.ai "cd /root/config; docker-compose -f ./chat/docker-compose.yml up -d mongo; docker-compose -f ./chat/docker-compose.yml up -d rocketchat"
