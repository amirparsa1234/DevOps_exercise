#!/bin/bash


sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow from 192.168.1.0/24 to any port 22 proto tcp

sudo ufw --force enable
sudo ufw status numbered > firewall_rules.txt
