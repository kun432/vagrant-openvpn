#!/bin/bash

set -euo pipefail

sudo systemctl start firewalld
sudo systemctl enable firewalld

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

sudo systemctl start dnsmasq
sudo systemctl enable dnsmasq
