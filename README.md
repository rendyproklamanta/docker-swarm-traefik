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

## Go to dir

```shell
cd v1
cd v2
cd v3
```

## Change traefik dashboard access by IP or domain

```shell
nano docker-compose.yml
```

## Create traefik network

```shell
docker network create --driver=overlay traefik-network
```

## Deploy traefik.yml first before deploy your app

```shell
docker stack deploy --compose-file docker-compose.yml traefik
```

## Install plugins

- modsecurity
- crowdsec

```shell
cd plugins
```

### Notes

- in v2 to share certificates across all nodes need traefik enterprise edition (paid version)
