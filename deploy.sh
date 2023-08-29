#!/bin/bash

mkdir -p /opt/docker-apps/mongo-data
chown 999 /opt/docker-apps/mongo-data
cp ./files/mongo/init-mongo.sh /opt/docker-apps/

mkdir -p /opt/nginx/{config,ssl}
cp ./files/nginx/config/default.conf ./files/nginx/config/nginx.conf /opt/nginx/config/

cp ./files/main/docker-compose.yml /opt/docker-apps/

while read line
do
	DOMAIN=$( echo ${line} |gawk -F"=" '{ print $1 }' )
	if [ "${DOMAIN}" = "DOMAIN1" ];
	then
		DOMAIN=$( echo ${line} |gawk -F"=" '{ print $2 }' )
		sed -i "s/NGINX-DOMAIN1/${DOMAIN}/g" /opt/nginx/config/nginx.conf
	fi
        if [ "${DOMAIN}" = "DOMAIN2" ];
        then
                DOMAIN=$( echo ${line} |gawk -F"=" '{ print $2 }' )
                sed -i "s/NGINX-DOMAIN2/${DOMAIN}/g" /opt/nginx/config/nginx.conf
        fi
done < VARS

while read line
do
        MONGOVAR=$( echo ${line} |gawk -F"=" '{ print $1 }' )
        if [ "${MONGOVAR}" = "MONGODB" ];
        then
                MONGOVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
                sed -i "s/MONGODB/${MONGOVAR}/g" /opt/docker-apps/docker-compose.yml
        fi
        if [ "${MONGOVAR}" = "MONGOROOTPASSWD" ];
        then
                MONGOVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
                sed -i "s/MONGOROOTPASSWD/${MONGOVAR}/g" /opt/docker-apps/docker-compose.yml
        fi
        if [ "${MONGOVAR}" = "MONGOUSER" ];
        then
                MONGOVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
                sed -i "s/MONGOUSER/${MONGOVAR}/g" /opt/docker-apps/docker-compose.yml
        fi
        if [ "${MONGOVAR}" = "MONGOPASSWD" ];
        then
                MONGOVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
                sed -i "s/MONGOPASSWD/${MONGOVAR}/g" /opt/docker-apps/docker-compose.yml
        fi
done < VARS