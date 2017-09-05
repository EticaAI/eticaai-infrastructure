#!/bin/bash

# Cadu Backup

# mkdir -p /backup/eticaai/cadu/temp # Create folder first

echo "Stoping mongo and rocketchat"
ssh root@cadu.vps.etica.ai "cd /root/config; docker-compose -f ./chat/docker-compose.yml stop rocketchat; docker-compose -f ./chat/docker-compose.yml stop mongo"

echo "rsync"
rsync -r --info=progress2 --delete root@cadu.vps.etica.ai:/root/config/* /backup/eticaai/cadu/temp

echo "Starting mongo and rocketchat"
ssh root@cadu.vps.etica.ai "cd /root/config; docker-compose -f ./chat/docker-compose.yml up -d mongo; docker-compose -f ./chat/docker-compose.yml up -d rocketchat"
