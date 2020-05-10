#!/bin/bash

set -euo pipefail

# update all
sudo yum update -y

# disable SELinux
sudo setenforce 0
sudo sed -i -e "s/^SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

# disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable firewalld

sudo timedatectl set-timezone Asia/Tokyo
sudo yum install chrony -y
sudo systemctl start chronyd
sudo systemctl enable chronyd

# enable epel
sudo yum install epel-release -y

# add some packages
sudo yum install -y nc tcpdump curl wget bind-utils
