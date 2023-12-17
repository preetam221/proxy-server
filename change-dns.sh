#!/bin/bash

# Backup default configuration, if not done.
if [ -f /etc/resolv.conf.default ]
then
    sudo rm /etc/resolv.conf
else
    sudo mv /etc/resolv.conf /etc/resolv.conf.default
fi

# Change DNS.
echo "Enter your preferred option:
1. Google
2. Cloudflare
3. Gcore
4. Adguard
5. Custom"

read inpt

# Google Public DNS
if [ "$inpt" == "1" ] || [ "$inpt" == "Google" ]
then
    sudo echo "## Google Public DNS

# IPv4 nameservers
nameserver 8.8.4.4
nameserver 8.8.8.8

# IPv6 Nameservers
nameserver 2001:4860:4860::8844
nameserver 2001:4860:4860::8888" >> /etc/resolv.conf

echo Done.

# Cloudflare 1.1.1.1
elif [ "$inpt" == "2" ] || [ "$inpt" == "Cloudflare" ]
then
    sudo echo "## Cloudflare 1.1.1.1

# IPv4 nameservers
nameserver 1.1.1.1
nameserver 1.0.0.1

# IPv6 Nameservers
nameserver 2606:4700:4700::1111
nameserver 2606:4700:4700::1001" >> /etc/resolv.conf

echo Done.

# Gcore Free Public DNS
elif [ "$inpt" == "3" ] || [ "$inpt" == "Gcore" ]
then
    sudo echo "## Gcore Free Public DNS

# IPv4 nameservers
nameserver 95.85.95.85
nameserver 2.56.220.2

# IPv6 Nameservers
nameserver 2a03:90c0:999d::1
nameserver 2a03:90c0:9992::1" >> /etc/resolv.conf

echo Done.

# Adguard Public DNS
elif [ "$inpt" == "4" ] || [ "$inpt" == "Adguard" ]
then
    sudo echo "## Adguard Public DNS

# IPv4 nameservers
nameserver 94.140.14.14
nameserver 94.140.15.15

# IPv6 Nameservers
nameserver 2a10:50c0::ad1:ff
nameserver 2a10:50c0::ad2:ff" >> /etc/resolv.conf

echo Done.

# Custom DNS
elif [ "$inpt" == "5" ] || [ "$inpt" == "Custom" ]
then
    echo "Choose an option:
    1. IPv4 Only
    2. Both, IPv4 & IPv6"
    read resp
    if [ "$resp" == "1" ] || [ "$resp" == "IPv4 Only" ]
    then
        echo "Nameserver 1:"
        read ns1
        echo "Nameserver 2:"
        read ns2

        sudo echo "# Custom DNS
nameserver $ns1
nameserver $ns2" >> /etc/resolv.conf
    elif [ "$resp" == "2" ] || [ "$resp" == "Both, IPv4 & IPv6" ]
    then
        echo "IPv4 Nameserver 1:"
        read ns1
        echo "IPv4 Nameserver 2:"
        read ns2
        echo "IPv6 Nameserver 1:"
        read ns3
        echo "IPv6 Nameserver 2:"
        read ns4

        sudo echo "## Custom DNS

# IPv4 nameservers
nameserver $ns1
nameserver $ns2

# IPv6 Nameservers
nameserver $ns3
nameserver $ns4" >> /etc/resolv.conf
    else
        exit 1
    fi

echo Done.

else
    echo "Error: Invalid response."
fi
