# cadu - vps139540.vps.ovh.ca - 149.56.101.234 - 2607:5300:0201:3100:0000:0000:0000:2c6f
# Ubuntu 16.04.2 LTS

# Install Docker
# See https://docs.docker.com/engine/installation/
# See https://docs.docker.com/engine/installation/linux/ubuntu/

sudo apt-get update

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

sudo apt-get install docker-ce

sudo apt-get install docker-ce