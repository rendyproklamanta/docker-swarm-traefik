#!/bin/bash

mkdir -p data && chown -R 755 data
mkdir -p crowdsec && chown -R 755 crowdsec
mkdir -p /var/log/crowdsec && chown -R 755 /var/log/crowdsec

docker stack rm traefik-crowdsec
docker stack deploy -c docker-compose.yml traefik-crowdsec