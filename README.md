# How To Use

## Create traefik dir & log

```shell
mkdir -p /var/lib/traefik
mkdir -p /var/log/traefik && chown -R 755 /var/log/traefik
```

## Clone this repository

```shell
cd /var/lib/traefik
git clone https://github.com/rendyproklamanta/docker-swarm-traefik.git .
```

## Change IP by using text replacing tool

```shell
find -type f -exec sed -i 's/IP_ADDRESS_SET/YOUR_IP_ADDRESS/g' {} +
```

## Deploy traefik.yml first before deploy your app

```shell
docker network create --driver=overlay traefik-network
docker stack deploy --compose-file v2/docker-compose.yml traefik
```

## Install plugins

- modsecurity
- crowdsec

```shell
cd plugins
```

### Notes

- in v2 to share certificates across all nodes need traefik enterprise edition (paid version)
