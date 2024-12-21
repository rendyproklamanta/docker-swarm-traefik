#!/bin/bash

# Create directories crowdsec
mkdir -p ./crowdsec
mkdir -p ./crowdsec/data
mkdir -p ./crowdsec/logs
chown -R 755 ./crowdsec

# Create directories openappsec
mkdir -p ./openappsec/conf
mkdir -p ./openappsec/data
mkdir -p ./openappsec/logs
chown -R 755 ./openappsec

docker stack deploy -c docker-compose.yml crowdsec-openappsec --detach=false