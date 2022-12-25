***Deploy traefik.yml first***

```
docker network create --driver=overlay traefik-public
export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID
docker stack deploy --compose-file docker-compose.traefik.yml mystack
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

***Updating service***
> Ps. before update service do build and push image

```
docker service update --image 127.0.0.1:5000/nodejs <service-name>
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

***Deploy stack***

```
docker stack deploy --compose-file docker-compose.yml mystack
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

***Add New Swarm Manager***
> login to Swarm Leader (manager)
```
docker node ls <- will show list nodes and copy ID
docker node promote <NODE_ID>
```
