#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

acme_file="/usr/local/acme.json"
domain=$(grep '\"add\"' $acme_file | awk -F '"' '{print $4}')

systemctl stop nginx &> /dev/null
sleep 1
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /dev/null
"/root/.acme.sh"/acme.sh --installcert -d ${domain} --fullchainpath /etc/x-ui/server.crt --keypath /etc/x-ui/server.key --ecc
sleep 1
systemctl start nginx &> /dev/null
