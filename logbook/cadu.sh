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

## Install KVM
# See https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#kvm-driver
sudo apt install libvirt-bin qemu-kvm

# TODO: Add yourself to the libvirtd group (use libvirt group for rpm based distros) so you don't need to sudo

### Install Install Minikube
## See https://kubernetes.io/docs/tasks/tools/install-minikube/
# Installing Minikube
# Install with snap on Ubuntu
# See https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-with-snap-on-ubuntu
sudo snap install kubectl --classic
kubectl version # Client Version: version.Info{Major:"1", Minor:"7", GitVersion:"v1.7.0", GitCommit:"d3ada0119e776222f11ec7945e6d860061339aad", GitTreeState:"clean", BuildDate:"2017-06-29T23:15:59Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"linux/amd64"}

# Enabling shell autocompletion
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

# Install Minikube according to the instructions for the latest release.
# CHECK NEW URL AT: https://github.com/kubernetes/minikube/releases
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.21.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
###

# Start minikube
minikube start # Error, fix it