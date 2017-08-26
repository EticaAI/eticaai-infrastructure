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