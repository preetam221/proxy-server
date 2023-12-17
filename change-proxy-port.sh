#!/bin/bash
if [ -e /etc/tinyproxy/tinyproxy.conf.default ]
then
    echo Enter your prefered port \(E.g. 443\)
    read port
    sudo sed -z 's/#\nPort/#\nPort $port #/g' /etc/tinyproxy/tinyproxy.conf
else
    sudo cp /etc/tinyproxy/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf.default
    echo Enter your prefered port \(E.g. 443\)
    read port
    sudo sed -z 's/#\nPort/#\nPort $port #/g' /etc/tinyproxy/tinyproxy.conf
fi