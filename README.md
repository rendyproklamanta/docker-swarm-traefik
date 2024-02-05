# How To Use

- ### Login to server and create dir
```
mkdir -p /var/lib/traefik
```

- ### Clone this repository

```
cd /var/lib/traefik
```
```
git clone https://github.com/rendyproklamanta/docker-swarm-traefik.git .
```

- ### Deploy traefik.yml first before deploy your app

> **Traefik v1**

_we recomend using v1 because have consul for swarm mode to share certificates accross all nodes_

```
docker network create --driver=overlay traefik-network
docker stack deploy --compose-file v1/docker-compose.traefik.yml traefik
```
- Open consul in browser http://<IP_ADDRESS>:8500

<hr>

> **Traefik v2**

 _in v2 to share certificates to all nodes need traefik enterprise edition (paid version)_

```
docker network create --driver=overlay traefik-network
docker stack deploy --compose-file v2/docker-compose.traefik.yml traefik
```

### Notes

-  For Traefik v1 only
```
> edit traefik.yml
(if add new node = 4)
> replicas to 4
> -bootstrap-expect=4
> And re-deploy traefik yml
```

- If traefik SSL error or add new node<br>

```
Remove service and delete volume in / consul-data in all nodes :

$ docker stack rm traefik
$ docker volume ls
$ docker volume rm traefik_Volume
```
