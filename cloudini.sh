#!/bin/bash
set -e

sudo timedatectl set-timezone Asia/Bangkok
sudo apt update -y 

#sudo useradd idaemon
#usermod -aG sudo idaemon
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
#sudo service sshd restart
echo "$USER:thaigaming" | sudo chpasswd
sudo service sshd restart
#sudo sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf

#update source maraidb
sudo apt install cron 
sudo apt install iputils-ping 
sudo apt install nano
sudo apt install apt-utils -y
sudo apt install software-properties-common gnupg2 -y
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
#mariadb10.8
#sudo add-apt-repository 'deb [arch=amd64] http://mariadb.mirror.globo.tech/repo/10.8/ubuntu jammy main'
#mariadb11.1
sudo add-apt-repository 'deb [arch=amd64] https://mirror.djvg.sg/mariadb/repo/11.1/ubuntu jammy main'

### create swap file edit the size 1g=2g 2g=2g 4g=4g
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab_$(date +%Y%m%d%H%M%S)
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf

#unattendence 
sudo sed -i.bak '/^APT::Periodic::Update-Package-Lists/ s/"0"/"1"/' /etc/apt/apt.conf.d/20auto-upgrades
sudo sed -i.bak '/^APT::Periodic::Unattended-Upgrade/ s/"0"/"1"/' /etc/apt/apt.conf.d/20auto-upgrades
sudo dpkg-reconfigure -f noninteractive unattended-upgrades


#start to install thing
#sudo apt install cron
#sudo apt install iputils-ping 
#sudo apt install nano
#prepare server
sudo apt update -y
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
sudo apt -qy -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" dist-upgrade

sudo apt autoclean -y && sudo apt autoremove -y
sudo shutdown -r now

#echo " DONE "
