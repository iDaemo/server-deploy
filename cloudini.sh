#!/bin/bash
set -e

#User task
echo "$USER:thaigaming" | sudo chpasswd
#sudo useradd idaemon
#usermod -aG sudo idaemon
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
#sudo service sshd restart

#update source maraidb
sudo apt-get install apt-transport-https curl
sudo mkdir -p /etc/apt/keyrings
sudo curl -o /etc/apt/keyrings/mariadb-keyring.pgp 'https://mariadb.org/mariadb_release_signing_key.pgp'
tee -a /etc/apt/sources.list.d/mariadb.sources <<EOF
X-Repolib-Name: MariaDB
Types: deb
URIs: https://download.nus.edu.sg/mirror/mariadb/repo/11.1/ubuntu
Suites: jammy
Components: main main/debug
Signed-By: /etc/apt/keyrings/mariadb-keyring.pgp
EOF

#Essential setup
sudo timedatectl set-timezone Asia/Bangkok
sudo apt update -y && sudo apt upgrade -y
sudo apt install cron
sudo apt install iputils-ping 
sudo apt install nano
sudo apt autoremove -y
sudo shutdown -r now

#echo " DONE "
