# How To Run Crowdsec

- Deploy

```shell
docker stack rm traefik-modsecurity
docker stack deploy -c docker-compose.yml traefik-modsecurity
```

- How to Use

```shell
deploy:
   labels:
      - "traefik.enable=true"
      - "traefik.docker.lbswarm=true"
      - "traefik.docker.network=traefik-network"
      - "traefik.http.routers.myapp.middlewares=modsecurity-plugin@file"  # <- here to use middleware
```
