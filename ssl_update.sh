#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

v2ray_qr_config_file="/usr/local/vmess_qr.json"
domain=$(grep '\"add\"' $v2ray_qr_config_file | awk -F '"' '{print $4}')
domain_bak=$(grep '\"add_bak\"' $v2ray_qr_config_file | awk -F '"' '{print $4}')

systemctl stop nginx &> /dev/null
sleep 1
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /dev/null
"/root/.acme.sh"/acme.sh --installcert -d ${domain} -d ${domain_bak} --fullchainpath /data/v2ray.crt --keypath /data/v2ray.key --ecc --force
sleep 1
systemctl start nginx &> /dev/null
