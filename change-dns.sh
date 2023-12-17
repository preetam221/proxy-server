#!/bin/bash

if [ ! -f /etc/resolv.conf.default ]
then
    sudo mv /etc/resolv.conf /etc/resolv.conf.default
fi