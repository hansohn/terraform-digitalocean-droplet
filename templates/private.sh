#!/usr/bin/env bash

# retrieve new lists of packages
sudo apt-get update

# How to Configure a Droplet as a VPC Gateway
# https://www.digitalocean.com/docs/networking/vpc/resources/droplet-as-gateway/

# route external traffic though internet gateway
gw=$(route -n | awk '$1 == "0.0.0.0" {print $2}')
ip route add 169.254.169.254 via $gw dev eth0
ip route change default via ${igw_private_ip}

# install additional packages
sudo apt-get install tmux
