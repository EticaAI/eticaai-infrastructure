# cadu - vps139540.vps.ovh.ca - 149.56.101.234 - 2607:5300:0201:3100:0000:0000:0000:2c6f
# Ubuntu 16.04.2 LTS

# Install Docker
# See https://docs.docker.com/engine/installation/
# See https://docs.docker.com/engine/installation/linux/ubuntu/

# ssh root@cadu.vps.etica.ai

sudo apt update
sudo apt upgrade -y

sudo hostnamectl set-hostname cadu.vps.etica.ai

sudo apt install htop tree jq -y

## Disable IPV6 support
#
echo "net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee /etc/sysctl.d/99-my-disable-ipv6.conf

# ask the system to use it
sudo service procps reload

# check the result
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
##

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt update

sudo apt-get install docker-ce -y

# Install Docker compose
# See https://docs.docker.com/compose/install/#install-compose

# change X.XX.X based on last release of https://github.com/docker/compose/releases
dockerComposeVersion=1.15.0

sudo curl -L https://github.com/docker/compose/releases/download/$dockerComposeVersion/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

mkdir /root/config
## Run something similiar to this on your host:
## scp -r /alligo/code/eticaai/eticaai-infrastructure/sysadmin/cadu/* root@cadu.vps.etica.ai:/root/config

## [docker-compose.yml] Edit image: rocketchat/rocket.chat:develop to specify which image you wish to use (see section Docker Images Available )
## [docker-compose.yml] Edit ROOT_URL to match your domain name or IP address

cd /root/config/chat

# Start the mongodb server by:
docker-compose up -d mongo

# The first time you start mongo, you’ll also need to initialize it before being able to use Rocket.Chat. Ensure that mongo is in the running state, then:
docker-compose up -d mongo-init-replica

# Once you’re sure that mongodb is up and running:
docker-compose up -d rocketchat


## Load Balancer

cd /root/config/loadbalancer

docker-compose up -d traefik


################################################################################
# Cheat cheet                                                                 #
################################################################################

cd /root/config # base direcotry for configurations

# Start chat
docker-compose -f ./chat/docker-compose.yml up -d mongo
docker-compose -f ./chat/docker-compose.yml up -d mongo-init-replica  # Only first time
docker-compose -f ./chat/docker-compose.yml up -d rocketchat

# Restart chat...
docker-compose -f ./chat/docker-compose.yml restart rocketchat

# Load Balancer
docker-compose -f ./loadbalancer/docker-compose.yml up -d traefik # Start

docker-compose -f ./loadbalancer/docker-compose.yml restart traefik # Restart

# debug traefik https://docs.traefik.io/configuration/backends/web/#configuration
curl -s "http://localhost:8080/api" | jq .