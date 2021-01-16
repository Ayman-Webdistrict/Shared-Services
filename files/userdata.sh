#!/bin/bash
squid_user="${squid_user}"
squid_pass="${squid_pass}"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install apache2-utils squid -y
cp /tmp/squid.conf /etc/squid/squid.conf
sudo sysctl -w net.ipv4.ip_forward=1

#generate password
htpasswd -nb $squid_user $squid_pass >> ./passwd
sudo cp ./passwd /etc/squid/passwd

/sbin/iptables -I INPUT -p tcp --dport 3128 -j ACCEPT
/sbin/iptables-save
systemctl enable squid
systemctl restart squid