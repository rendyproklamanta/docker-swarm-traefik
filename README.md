***Requirement***

```
3 servers = manager (3 is minimum for fault tolerant)
2 servers = worker (optional, you can use manager only and not use worker)

NOTE: you need odd servers for fault tolerant and keep your web app running
- 3 nodes running = 1 node down
- 5 nodes running = 2 nodes down
```

***Install swarmpit to manage swarm***

```
> login to server "Leader" manager
$ git clone https://github.com/swarmpit/swarmpit -b master
docker stack deploy -c swarmpit/docker-compose.yml swarmpit
> Open browser http://<IP_ADDRESS>:888
```

***Assigned node as swarm manager***

```
> login to server "Leader" manager
$ docker swarm join-token manager
> copy text and login to 2 servers for assign as manager
$ docker swarm join --token <TOKEN> <IP_LEADER>:2377
```

***Deploy traefik.yml first before deploy your app***

**traefik-v1**
* *we recomend using v1 because have consul for swarm mode to share certificates accross all nodes*
```
docker network create --driver=overlay traefik-public
docker stack deploy --compose-file traefik/traefik-v1.yml traefik
```

**traefik-v2**
* *in v2 to share certificates to all nodes need traefik enterprise edition (paid)*
```
docker network create --driver=overlay traefik-public
docker config create traefik-tls.yml traefik-tls.yml
docker stack deploy --compose-file traefik/traefik-v2.yml traefik
```

***Create registry - Run below command one time only if you want to store docker registry in local***

```
docker service create --name registry --publish published=5000,target=5000 registry:2
```

***Build image to store in local registry***

```
docker build -t 127.0.0.1:5000/nodejs .
docker-compose push
```

> Remove old image and container

```
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
docker container prune
```

***Check image***

```
docker images
docker ps
```

***Deploy stack/service***

```
docker stack deploy --compose-file docker-compose-v1.yml mystack
```

***Updating service***
> Ps. before update service do build and push image

```
docker service update --image 127.0.0.1:5000/nodejs <service-name> -d
```

***Scaling app (optional)***

```
docker service scale <service-name>=5
```

***Check services and log***

```
docker stack ls
docker services ls
docker service logs <service-name>
```

***Promote Worker as new Manager***
> login to swarm leader (manager)
```
docker node ls <- will show list nodes and copy ID worker
docker node promote <NODE_ID_WORKER>
```
