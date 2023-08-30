#!/bin/bash

mkdir -p /opt/docker-apps/mongo-data
chown 999 /opt/docker-apps/mongo-data
cp ./files/mongo/init-mongo.sh /opt/docker-apps/

mkdir -p /opt/nginx/config /opt/nginx/ssl
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

while read line
do
        NODEVAR=$( echo ${line} |gawk -F"=" '{ print $1 }' )
        if [ "${NODEVAR}" = "PATHNODE1" ];
        then
                NODEVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
                sed -i "s|PATHNODE1|${NODEVAR}|g" /opt/docker-apps/docker-compose.yml
        fi
        if [ "${NODEVAR}" = "PATHNODE2" ];
        then
                NODEVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
                sed -i "s|PATHNODE2|${NODEVAR}|g" /opt/docker-apps/docker-compose.yml
        fi
        if [ "${NODEVAR}" = "PATHNODE3" ];
        then
                NODEVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
                sed -i "s|PATHNODE3|${NODEVAR}|g" /opt/docker-apps/docker-compose.yml
        fi
        if [ "${NODEVAR}" = "PATHNODE4" ];
        then
                NODEVAR=$( echo ${line} |gawk -F"=" '{ print $2 }' )
                sed -i "s|PATHNODE4|${NODEVAR}|g" /opt/docker-apps/docker-compose.yml
        fi
done < VARS

echo ""
echo "Deploy Done."
echo "!!!!!!!!!!!!"
echo "up docker by command below"
echo "cd /opt/docker-apps/"
echo "docker-compose up -d || docker compose up -d"

exit 0
