# How To Run Crowdsec

- Deploy container first
  
```shell
chmod +x init.sh && ./init.sh
```

- Enroll first time only : copy Key from crowdsec dashboard console website and insert after enroll xxxx

```shell
sudo docker exec crowdsec cscli console enroll xxxx
```

- Create bouncer key for traefik

```shell
sudo docker exec crowdsec cscli bouncers add traefik-bouncer
```

- Copy key and insert to : LAPI_CROWDSEC_BOUNCER__KEY

- Or you can change by using text replacing tool

```shell
cd /var/lib/traefik
find -type f -exec sed -i 's/LAPI_CROWDSEC_BOUNCER_KEY/YOUR_GENERATED_BOUNCER_KEY/g' {} +
```

- Re-deploy after changing LAPI_CROWDSEC_BOUNCER__KEY
  
```shell
chmod +x init.sh && ./init.sh
```

- How to Use

```shell
deploy:
   labels:
      - "traefik.enable=true"
      - "traefik.docker.lbswarm=true"
      - "traefik.docker.network=traefik-network"
      - "traefik.http.routers.app-production.middlewares=crowdsec-plugin@file" # <- here to use middleware
```