# How To Run Crowdsec

- Deploy container first
  
```shell
chmod +x init.sh && ./init.sh
```

- Enroll first time only : copy Key from crowdsec dashboard console website and insert after enroll xxxx

```shell
sudo docker exec -it $(docker ps -q -f "name=crowdsec") cscli console enroll xxxx
```

- Create bouncer key for traefik

```shell
sudo docker exec -it $(docker ps -q -f "name=crowdsec") cscli bouncers add traefik-bouncer
```

- Copy key and insert to LAPI_CROWDSEC_BOUNCER_KEY using replacing tool

```shell
cd /var/lib/traefik
find . -type f -exec sed -i "s|LAPI_CROWDSEC_BOUNCER_KEY|YOUR_KEY_HERE|g" {} +
```

- Restart

```sh
cd /var/lib/traefik/plugins/crowdsec
./init.sh
```

- Update crowdsec database daily by cron

```shell
crontab -e

0 0 * * * docker exec $(docker ps -q -f "name=crowdsec") cscli hub update >> /var/log/crowdsec_update.log 2>&1
```

- How to Use

```shell
labels:
   - "traefik.enable=true"
   - "traefik.docker.lbswarm=true"
   - "traefik.docker.network=traefik-network"
   - "traefik.http.routers.app-production.middlewares=crowdsec-plugin@file" # <- here to use middleware
```

- Check

```shell
docker exec -it $(docker ps -q -f "name=crowdsec") cscli metrics
```

- Test

```shell
docker exec -it $(docker ps -q -f "name=crowdsec") cscli decisions list
docker exec -it $(docker ps -q -f "name=crowdsec") cscli decisions add --ip 192.168.0.100
docker exec -it $(docker ps -q -f "name=crowdsec") cscli decisions delete --ip 192.168.0.100
```
