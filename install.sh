#!/bin/bash
### upgrade everything
sudo apt update && sudo apt upgrade -y

### messing with ssh
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
#sudo sed -i "/^[^#]*ClientAliveInterval[[:space:]]0/c\ClientAliveInterval 60" /etc/ssh/sshd_config
echo 'ClientAliveInterval 60' | sudo tee -a /etc/ssh/sshd_config
sudo service sshd restart

### create swap file edit the size 1g=2g 2g=2g 4g=4g
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
cp /etc/fstab /etc/fstab_$(date +%Y%m%d%H%M%S)
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf

sed -i '/^#PasswordAuthentication/s/yes/no/' /etc/ssh/sshd_config
