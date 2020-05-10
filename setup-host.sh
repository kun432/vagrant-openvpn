#!/bin/bash

set -euo pipefail


GW_IPADDR=$(nmcli con show "System eth1" | grep "ipv4.addresses" | awk '{ print $2 }' | awk -F"." '{ print $1 "." $2 "." $3 }' ).10

sudo nmcli c m "System eth0" ipv4.never-default yes
sudo nmcli c m "System eth0" ipv4.ignore-auto-dns yes
sudo nmcli c m "System eth1" ipv4.never-default no
sudo nmcli c m "System eth1" ipv4.gateway $GW_IPADDR
sudo nmcli c m "System eth1" ipv4.dns $GW_IPADDR
sudo nmcli c up "System eth0"
sudo nmcli c up "System eth1"
