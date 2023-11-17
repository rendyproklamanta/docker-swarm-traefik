### Clone this repository

```
git clone https://github.com/rendyproklamanta/docker-swarm-traefik.git
```

<hr>

## Deploy traefik.yml first before deploy your app

**traefik-v1**

- _we recomend using v1 because have consul for swarm mode to share certificates accross all nodes_

```
docker network create --driver=overlay traefik-network
docker stack deploy --compose-file v1/docker-compose.traefik.yml traefik
> Open consul in browser http://<IP_ADDRESS>:8500
```

**traefik-v2**

- _in v2 to share certificates to all nodes need traefik enterprise edition (paid version)_

```
docker network create --driver=overlay traefik-network
docker stack deploy --compose-file v2/docker-compose.traefik.yml traefik
```

##### Note for Traefik v1

```
!! If traefik SSL error
!! If add new node
> remove service and delete consul-data volume in all nodes :

$ docker stack rm traefik
$ docker volume rm traefik_consul-data <- run command in all nodes

> edit traefik.yml
(if add new node = 4)
> replicas to 4
> -bootstrap-expect=4
> And re-deploy traefik yml
```