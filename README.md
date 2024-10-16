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

## Change traefik dashboard access by IP or domain

```shell
nano docker-compose.v(:num:).yml

ex: 
nano docker-compose.v2.yml
```

## Create traefik network

```shell
docker network create --driver=overlay traefik-network
```

## Deploy traefik.yml first before deploy your app

```shell
docker stack deploy --compose-file docker-compose.v(:num:).yml traefik

ex: 
docker stack deploy --compose-file docker-compose.v3.yml traefik
```

## Install plugins

```shell
cd plugins
```

## List plugins

- modsecurity
- crowdsec

### Notes

- in v2 and v3 to share certificates across all nodes need traefik enterprise edition (paid version)
