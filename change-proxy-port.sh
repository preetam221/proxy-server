#!/bin/bash
if [ -e /etc/tinyproxy/tinyproxy.conf.default ]
then
    echo Enter your prefered port \(E.g. 443\)
    read port
    sudo sed 's/^Port.*/Port '$port'/' /etc/tinyproxy/tinyproxy.conf|sudo tee /etc/tinyproxy/tinyproxy.conf.output
    sudo rm /etc/tinyproxy/tinyproxy.conf
    sudo mv /etc/tinyproxy/tinyproxy.conf.output /etc/tinyproxy/tinyproxy.conf
    sudo systemctl restart tinyproxy.service
    echo Done.
else
    sudo cp /etc/tinyproxy/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf.default
    echo Enter your prefered port \(E.g. 443\)
    read port
    sudo sed 's/^Port.*/Port '$port'/' /etc/tinyproxy/tinyproxy.conf|sudo tee /etc/tinyproxy/tinyproxy.conf.output
    sudo rm /etc/tinyproxy/tinyproxy.conf
    sudo mv /etc/tinyproxy/tinyproxy.conf.output /etc/tinyproxy/tinyproxy.conf
    sudo systemctl restart tinyproxy.service
    echo Done.
fi