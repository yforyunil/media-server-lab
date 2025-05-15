#!/bin/bash

services=("docker" "dnsmasq")
logs="/var/log/runtime_check.log"
#dockcer dnsmasq check

for serv in ${services[@]}; do

	if ! systemctl is-active --quiet ${serv}; then
		echo "$(date): $serv is down... Re-starting" >> "${logs}"
		systemctl restart "$serv" 2>> "${logs}"
	else
		echo "$(date) $serv is running.">>"${logs}"
	fi
done

#Nginx check

if [ -z "$(docker ps -q -f name=nginx-reverse-proxy)" ]; then 
	echo "$(date): Nginx down: Restarting..." >> "${logs}"
	docker restart nginx-reverse-proxy &>> "${logs}"
else	
	echo "$(date): Nginx is running" >> "${logs}"
fi
