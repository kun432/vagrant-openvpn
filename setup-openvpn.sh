#!/bin/bash

set -euo pipefail

# install openvpn
sudo yum --enablerepo=epel -y install openvpn easy-rsa
sudo mkdir -p /etc/openvpn/easyrsa3
sudo cp -r /usr/share/easy-rsa/3/* /etc/openvpn/easyrsa3/.

