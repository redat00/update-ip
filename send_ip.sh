#!/bin/bash
# This file should be on local server

current_ip=$(cat /var/tmp/currentip)
new_ip=$(curl -s http://ipecho.net/plain)
current_date=$(date "+[%Y-%m-%d %H:%M:%S]")

if [[ "$current_ip" == "$new_ip" ]]; then
	exit 0
else
	echo "$current_date Updating tmp files" >> /home/log/ip_update.log
	echo $new_ip > /var/tmp/currentip
	echo "$current_date scp file to distant server" >> /home/log/ip_update.log
	scp /var/tmp/currentip distant-server:/var/tmp/newip
	exit 0
fi
