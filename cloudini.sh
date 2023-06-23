#!/bin/bash
sudo timedatectl set-timezone Asia/Bangkok
sudo apt update -y && sudo apt upgrade -y
apt install cron
apt install iputils-ping 
apt install cron
#sudo useradd idaemon
echo "$USER:thaigaming" | sudo chpasswd
#usermod -aG sudo idaemon
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
sudo apt autoremove -y
echo " DONE "
