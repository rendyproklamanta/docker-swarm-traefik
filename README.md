Create registry as local - One time only

```
docker service create --name registry --publish published=5000,target=5000 registry:2
```

Compose traefik.yml first

```
docker stack deploy --compose-file docker-compose.traefik.yml <stack-name>
```

Build image

```
docker build -t 127.0.0.1:5000/nodejs .
docker-compose push
```

Check image

```
docker images
docker ps
```

Deploy stack

```
docker stack deploy --compose-file docker-compose.yml <stack-name>
docker service scale <service-name>=2
```

Check services and log

```
docker stack ls
docker services ls
docker service logs <service-name>
```
