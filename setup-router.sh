#!/bin/bash

set -euo pipefail

sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo nmcli con mod "System eth0" connection.zone external
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

sudo yum install dnsmasq -y

cat <<EOF | sudo tee -a /etc/hosts-a.private
192.168.0.10 gw.a.private
192.168.0.20 vpn-client.a.private
10.0.0.20 vpn-server.b.private gw.b.private
EOF

cat <<EOF | sudo tee -a /etc/hosts-b.private
192.168.100.10 gw.b.private
192.168.100.20 vpn-server.b.private
192.168.100.30 web-server.b.private
10.0.0.10 vpn-client.a.private gw.a.private
EOF

if [ `hostname` = "gw.a.private" ]; then
cat <<EOF | sudo tee -a /etc/dnsmasq.d/a.private.conf
port=53
domain-needed
expand-hosts
bogus-priv
no-hosts
addn-hosts=/etc/hosts-a.private
local=/a.private/
EOF
elif [ `hostname` = "gw.b.private" ]; then
cat <<EOF | sudo tee -a /etc/dnsmasq.d/b.private.conf
port=53
domain-needed
expand-hosts
bogus-priv
no-hosts
addn-hosts=/etc/hosts-b.private
local=/b.private/
EOF
fi

