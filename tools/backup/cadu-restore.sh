#!/bin/bash
#===============================================================================
#
#          FILE:  cadu-restore.sh
#
#         USAGE:  ./cadu-restore.sh
#
#   DESCRIPTION:  Restore a backup created with cadu-backup.sh.
#                 Stop MongoDB and Rocket.Chat if necessary, then rsync local
#                 folder with remote cadu /root/config folder, then start
#                 MongoDB and Rocket.Chat.
#
#       OPTIONS:  ---
#  REQUIREMENTS:  Requires passwordless `ssh root@cadu.vps.etica.ai`.
#                 Requires that cadu already has a working docker, with all
#                 containers working, even if no content.
#          BUGS:  TODO 1: this script should stop for any error (fititnt, 2017-09-05 01:08 BRT)
#                 TODO 2: this script should only restore if local folder really have some content (avoid destroy remote)
#         NOTES:  ---
#        AUTHOR:  Emerson Rocha <emerson@alligo.com.br>
#       COMPANY:  Etica.AI
#       VERSION:  1.0
#       CREATED:  2017-09-05 01:20:00 BRT
#      REVISION:  ---
#===============================================================================

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
