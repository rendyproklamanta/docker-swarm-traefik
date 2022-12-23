Create registry as local - One time only
```
docker service create --name registry --publish published=5000,target=5000 registry:2
```

Compose traefik.yml first
```
docker-compose -f docker-compose.traefik.yml up -d
```

Build image
```
docker-compose up -d
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
```

Check services and log
```
docker stack ls
docker services ls
docker service logs <service-name>
```