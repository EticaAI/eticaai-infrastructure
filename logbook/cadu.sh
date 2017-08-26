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


## Installing kubelet and kubeadm
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm

# kubeadm init
kubeadm init --pod-network-cidr=10.244.0.0/16

### TODO check if this will blow up
# root@cadu:~# kubeadm init
# [kubeadm] WARNING: kubeadm is in beta, please do not use it for production clusters.
# [init] Using Kubernetes version: v1.7.4
# [init] Using Authorization modes: [Node RBAC]
# [preflight] Running pre-flight checks
# [preflight] WARNING: docker version is greater than the most recently validated version. Docker version: 17.06.1-ce. Max validated version: 1.12
# [kubeadm] WARNING: starting in 1.8, tokens expire after 24 hours by default (if you require a non-expiring token use --token-ttl 0)
# [certificates] Generated CA certificate and key.
# [certificates] Generated API server certificate and key.
# [certificates] API Server serving cert is signed for DNS names [cadu.vps.etica.ai kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 149.56.101.234]
# [certificates] Generated API server kubelet client certificate and key.
# [certificates] Generated service account token signing key and public key.
# [certificates] Generated front-proxy CA certificate and key.
# [certificates] Generated front-proxy client certificate and key.
# [certificates] Valid certificates and keys now exist in "/etc/kubernetes/pki"
# [kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/admin.conf"
# [kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/kubelet.conf"
# [kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/controller-manager.conf"
# [kubeconfig] Wrote KubeConfig file to disk: "/etc/kubernetes/scheduler.conf"
# [apiclient] Created API client, waiting for the control plane to become ready



### (3/4) Installing a pod network

# Note: I will stop here. kubeadm Maturity is alpha, and other more stable
#       strategies need bare metal servers or a AWS/Google Cloud/etc.
#       Is possible, just need dedicated hardware (fititnt, 2017-08-26 02:57 BRT)