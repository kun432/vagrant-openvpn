#!/bin/bash

set -euo pipefail

# install openvpn
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

