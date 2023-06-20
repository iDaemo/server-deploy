#!/bin/bash
### upgrade everything
sudo apt update && sudo apt upgrade -y

### messing with ssh
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
#sudo sed -i "/^[^#]*ClientAliveInterval[[:space:]]0/c\ClientAliveInterval 60" /etc/ssh/sshd_config
echo 'ClientAliveInterval 60' | sudo tee -a /etc/ssh/sshd_config
sudo service sshd restart

### another options
#sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
#systemctl restart sshd
#service sshd restart

#TODO: replace bob with your desired username
useradd idaemon
echo "thaigaming" | passwd --stdin bob

### create swap file edit the size 1g=2g 2g=2g 4g=4g
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
cp /etc/fstab /etc/fstab_$(date +%Y%m%d%H%M%S)
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf


timedatectl set-timezone Asia/Bangkok

### redis recommended
I set it up very easily.
1. Ensure Redis is up and running
2. Enable Redis via the WordPress plugin, only setting I had to change was password because I use requirepass
Additionally, I’d recommend these settings in redis.conf:
maxmemory 100mb maxmemory-policy allkeys-lru maxmemory-samples 10 appendonly yes
and disable snapshotting, comment out the lines beginning with “save” to do this, for example,
#save 900 1 #save 300 10 #save 60 10000
I’d also add vm.overcommit_memory = 1 to /etc/sysctl.conf.
Also disable transparent huge pages, echo never > /sys/kernel/mm/transparent_hugepage/enabled


### CYBERPANEL BACKUP AFTER SETUP GOOGLE
/usr/local/CyberCP/bin/python /usr/local/CyberCP/IncBackups/IncScheduler.py Weekly



