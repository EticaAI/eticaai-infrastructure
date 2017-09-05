#!/bin/bash
#===============================================================================
#
#          FILE:  cadu-backup.sh
#
#         USAGE:  ./cadu-backup.sh
#
#   DESCRIPTION:  Backup cadu server (mongodb and dockerfiles configuration).
#                 Stop MongoDB and Rocket.Chat, rsync cadu with local folder,
#                 then start MongoDB and Rocket.Chat.
#
#
#       OPTIONS:  ---
#  REQUIREMENTS:  Requires passwordless `ssh root@cadu.vps.etica.ai`.
#                 Requires `mkdir -p /backup/eticaai/cadu/` 1st time
#          BUGS:  ---
#         NOTES:  TODO: convert to make backup without stoping the services
#        AUTHOR:  Emerson Rocha <emerson@alligo.com.br>
#       COMPANY:  Etica.AI
#       VERSION:  1.0
#       CREATED:  2017-09-05 00:54:00 BRT
#      REVISION:  ---
#===============================================================================

echo "Stoping mongo and rocketchat"
ssh root@cadu.vps.etica.ai "cd /root/config; docker-compose -f ./chat/docker-compose.yml stop rocketchat; docker-compose -f ./chat/docker-compose.yml stop mongo"

echo "rsync"
rsync -r --info=progress2 --delete root@cadu.vps.etica.ai:/root/config/* /backup/eticaai/cadu/temp

echo "Starting mongo and rocketchat"
ssh root@cadu.vps.etica.ai "cd /root/config; docker-compose -f ./chat/docker-compose.yml up -d mongo; docker-compose -f ./chat/docker-compose.yml up -d rocketchat"
