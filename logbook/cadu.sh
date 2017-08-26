################################################################################
# Logbook: cadu (cadu.vps.etica.ai)
# Type: VPS (KVM OpenStack)
# Specs: 1vCore (2.4Ghz); 4GB RAM (3855mb); SSD 20 GB
# IP4: 149.56.101.234
# IP6: 2607:5300:0201:3100:0000:0000:0000:2c6f
# SO: Ubuntu 16.04 Server (64 bits)
################################################################################

sudo apt update
sudo apt upgrade

sudo hostnamectl set-hostname cadu.vps.etica.ai

sudo apt install htop

#### Kubernetes on Ubuntu
#
### Using kubeadm to Create a Cluster
### See https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
#
## Installing kubeadm
## See https://kubernetes.io/docs/setup/independent/install-kubeadm/
# Installing Docker
# See https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce

sudo docker run hello-world # Testing docker

## Installing kubectl
## See https://kubernetes.io/docs/tasks/tools/install-kubectl/
sudo snap install kubectl --classic
kubectl cluster-info # Test if enabled

# Enabling shell autocompletion
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
