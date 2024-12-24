#!/bin/bash

# Create directories openappsec
mkdir -p conf && chown -R 755 conf
mkdir -p data && chown -R 755 data
mkdir -p logs && chown -R 755 logs

docker stack deploy -c docker-compose.yml openappsec-agent --detach=false