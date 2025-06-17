# How To Use

```sh
Traefik v3 has bugs :
- Show bad gateway when docker service update
```

## Create traefik dir & log

```shell
sudo mkdir -p /var/lib/traefik
sudo mkdir -p /var/log/traefik && sudo chmod -R 755 /var/log/traefik
```

## Clone this repository

```shell
cd /var/lib/traefik
sudo git clone https://github.com/rendyproklamanta/docker-swarm-traefik.git .
```

## Change traefik dashboard access by IP or domain

```shell
nano docker-compose.v(:num:).yml
```

```shell
sudo nano docker-compose.v2.yml
```

## Create traefik network

```shell
sudo docker network create --driver=overlay traefik-network
```

## Deploy traefik.yml first before deploy your app

```shell
docker stack deploy --compose-file docker-compose.v(:num:).yml traefik
```

```shell
sudo docker stack deploy --compose-file docker-compose.v2.yml traefik --detach=false
```

## Install plugins

```shell
cd plugins
```

## List plugins

- modsecurity
- crowdsec

## Use your own SSL cert

- Rename certs/domain1 to real yourdomain
- Insert your crt and key to the directory
- Then edit in config/tls.yaml
- Deploy traefik, 
- Edit you deployment.yml

```sh
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.service-name.tls=true" <-- use this instead certresolver or remove certresolver
```
### If your website still serve Let's Encrypt as SSL

- Delete acme.json by 

```sh
docker ps
docker exec -it <traefik_container_id> sh
rm -rf /certificates/acme.json
```

- Redeploy traefik


### Notes

- in v2 and v3 to share certificates across all nodes need traefik enterprise edition (paid version)



