#!/bin/bash

# Create default configuration backup.
if [ ! -f /etc/tinyproxy/tinyproxy.conf.default ]
then
    sudo cp /etc/tinyproxy/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf.default
fi

# Change the port as per preference.
echo Enter your prefered port \(E.g. 443\)
read port
sudo sed 's/^Port.*/Port '$port'/' /etc/tinyproxy/tinyproxy.conf|sudo tee /etc/tinyproxy/tinyproxy.conf.output
sudo rm /etc/tinyproxy/tinyproxy.conf
sudo mv /etc/tinyproxy/tinyproxy.conf.output /etc/tinyproxy/tinyproxy.conf
sudo systemctl restart tinyproxy.service
echo Done.
