***Create registry as local - One time only***

```
docker service create --name registry --publish published=5000,target=5000 registry:2
```

***Compose traefik.yml first***

```
docker stack deploy --compose-file docker-compose.traefik.yml mystack
```

***Build image***

```
docker build -t 127.0.0.1:5000/nodejs .
docker-compose push
```

***Updating service***
> Ps. before update service do build and push image

```
docker service update --image 127.0.0.1:5000/nodejs nodejs_backend
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
docker service scale nodejs_backend=5
```

***Check services and log***

```
docker stack ls
docker services ls
docker service logs <service-name>
```

***Add New Swarm Worker***

```
docker service update registry

```
