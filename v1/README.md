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

## Deploy traefik.yml first before deploy your app

- we recomend using v1 because have consul for swarm mode to share certificates accross all nodes_

```shell
docker network create --driver=overlay traefik-network
docker stack deploy --compose-file v1/docker-compose.yml traefik --detach=false
```

- Open consul in browser http://<IP_ADDRESS>:8500

### Notes

```shell
> edit traefik.yml
(if add new node = 4)
> replicas to 4
> -bootstrap-expect=4
> And re-deploy traefik yml
```

- If traefik SSL error or add new node

```shell
Remove service and delete volume in / consul-data in all nodes :

$ docker stack rm traefik
$ docker volume ls
$ docker volume rm traefik_Volume
```
