#!/bin/bash

set -euo pipefail

sudo firewall-cmd --zone=external --change-interface=eth0 --permanent
sudo firewall-cmd --zone=external --change-interface=eth1 --permanent
sudo firewall-cmd --zone=trusted  --change-interface=eth2 --permanent
sudo firewall-cmd --zone=external --add-masquerade --permanent
#if [ `hostname` = "gw.b.private" ]; then
#  sudo firewall-cmd --zone=external --add-forward-port=port=1194:proto=udp:toport=1194:toaddr=192.168.100.20 --permanent
#fi
sudo firewall-cmd --set-log-denied=all
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --reload
