#!/bin/bash
# This file should be on distant server

current_ip=$(cat /var/tmp/currentip)
new_ip=$(cat /var/tmp/newip)
current_date=$(date "+[%Y-%m-%d %H:%M:%S]")

if [[ "$current_ip" == "$new_ip" ]]; then
	exit 0 
else
	echo "$current_date Updating IP in nginx configuration" >> /home/log/ip_update.log
	sed -i -e "s/$current_ip/$new_ip/g" /etc/nginx/sites-available/default
	if [ "nginx -t" ]; then
		echo "$current_date Reloading nginx" >> /home/log/ip_update.log
		echo "$current_date Updating tmp files" >> /home/log/ip_update.log
		echo $new_ip > /var/tmp/currentip
		exit 0
	else
		echo "$current_date Error while trying to reload nginx" >> /home/log/ip_update.log
		exit 1
	fi
fi
