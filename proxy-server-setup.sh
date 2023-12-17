#!/bin/bash

# Update Package repositories
sudo apt-get update

# Install required packages
sudo apt-get install -y tinyproxy sed figlet wget

# Configure the server
sudo systemctl enable tinyproxy.service
sudo cp /etc/tinyproxy/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf.default
sudo sed -i 's/Allow 127.0.0.1/#Allow 127.0.0.1/g' /etc/tinyproxy/tinyproxy.conf
sudo sed -i 's/Allow ::1/#Allow ::1/g' /etc/tinyproxy/tinyproxy.conf
sudo sed -i 's/#DisableViaHeader Yes/DisableViaHeader Yes/g' /etc/tinyproxy/tinyproxy.conf
sudo echo "#
# MinSpareServers/MaxSpareServers: These settings set the upper and
# lower limit for the number of spare servers that should be available.
#
# If the number of spare servers falls below MinSpareServers then new
# server processes will be spawned.  If the number of servers exceeds
# MaxSpareServers then the extras will be killed off.
#
MinSpareServers 20
MaxSpareServers 50
#
# StartServers: The number of servers to start initially.
#
StartServers 20
#
# MaxRequestsPerChild: The number of connections a thread will handle
# before it is killed. In practise this should be set to 0, which
# disables thread reaping. If you do notice problems with memory
# leakage, then set this to something like 10000.
#
MaxRequestsPerChild 1000" >> /etc/tinyproxy/tinyproxy.conf

# Change default port to 443
sudo sed -i 's/Port 8888/Port 443/g' /etc/tinyproxy/tinyproxy.conf
sudo systemctl restart tinyproxy.service

# Edit DNS
sudo cp /etc/systemd/resolved.conf /etc/systemd/resolved.conf.default
sudo sed -i 's/#DNS=/DNS=8.8.4.4/g' /etc/systemd/resolved.conf
sudo sed -i 's/#FallbackDNS=/FallbackDNS=8.8.8.8/g' /etc/systemd/resolved.conf
sudo systemctl restart systemd-resolved
sudo mv /etc/resolv.conf /etc/resolv.conf.default
sudo echo "## Google Public DNS

#IPv4 nameservers
nameserver 8.8.4.4
nameserver 8.8.8.8

#IPv6 Nameservers
nameserver 2001:4860:4860::8844
nameserver 2001:4860:4860::8888" >> /etc/resolv.conf

# Success Message
figlet SUCCESS.
echo You can now connect to your proxy using the credentials below:
echo Address: $(wget -qO- ipinfo.io/ip)
echo Port: 443