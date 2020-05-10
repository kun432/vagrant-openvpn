#!/bin/bash

set -euo pipefail

sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo nmcli con mod "System eth0" connection.zone public
sudo nmcli con mod "System eth1" connection.zone external
sudo nmcli con mod "System eth2" connection.zone trusted
sudo nmcli con up "System eth0"
sudo nmcli con up "System eth1"
sudo nmcli con up "System eth2"
sudo firewall-cmd --zone=external --add-masquerade --permanent
sudo firewall-cmd --zone=public --add-masquerade --permanent
#if [ `hostname` = "gw.b.private" ]; then
#  sudo firewall-cmd --zone=external --add-forward-port=port=1194:proto=udp:toport=1194:toaddr=192.168.100.20 --permanent
#fi
sudo firewall-cmd --set-log-denied=all
sudo firewall-cmd --reload

cat <<EOF | sudo tee -a /etc/hosts-dnsmasq
10.0.0.10 vpn-client.a.private gw.a.private
10.0.0.20 vpn-server.b.private gw.b.private
EOF

sudo yum install dnsmasq -y
cat <<EOF | sudo tee -a /etc/dnsmasq.d/local-dns.conf
port=53
no-hosts
addn-hosts=/etc/hosts-dnsmasq
expand-hosts
domain-needed
bogus-priv
EOF
