#!/bin/bash

mkdir -p data && chown -R 755 data
mkdir -p crowdsec && chown -R 755 crowdsec

# Create logger directories
mkdir -p /var/log/crowdsec && chown -R 755 /var/log/crowdsec
mkdir -p /var/log/nginx
mkdir -p /var/log/traefik

docker stack rm traefik-crowdsec
docker stack deploy -c docker-compose.yml traefik-crowdsec --detach=false