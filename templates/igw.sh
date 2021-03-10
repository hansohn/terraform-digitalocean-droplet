#!/usr/bin/env bash

# retrieve new lists of packages 
sudo apt-get update

# How to Configure a Droplet as a VPC Gateway
# https://www.digitalocean.com/docs/networking/vpc/resources/droplet-as-gateway/

# ip forwarding
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

# configure nat
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
sudo apt-get install -y iptables iptables-persistent
inf=$(route -n | awk '$1 == "0.0.0.0" {print $8}')
iptables -t nat -A POSTROUTING -s ${vpc_network_prefix} -o $inf -j MASQUERADE
iptables-save > /etc/iptables/rules.v4

# fail2ban
if [ "${enable_bastion}" == "true" ]; then
  sudo apt-get install -y fail2ban
  cat << EOF >> /etc/fail2ban/jail.d/defaults-debian.conf
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
banaction = iptables-multiport
            slack-notify
EOF
  curl https://raw.githubusercontent.com/hansohn/fail2ban-slack/master/slack-notify.conf --output /etc/fail2ban/action.d/slack-notify.conf
  if [ "${enable_notifications}" == "true" ]; then
    mkdir -p /etc/systemd/system/fail2ban.service.d
    cat << EOF >> /etc/systemd/system/fail2ban.service.d/override.conf
[Service]
Environment=SLACK_CHANNEL=${slack_channel}
Environment=SLACK_USERNAME=${slack_username}
Environment=SLACK_ICON=${slack_icon}
Environment=SLACK_WEBHOOK_URL=${slack_webhook_url}
EOF
  fi
  systemctl daemon-reload
  systemctl restart fail2ban
fi

# install additional packages
sudo apt-get install tmux
