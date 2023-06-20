## RUN Wordpress

```
mkdir /mnt/wp/data

cd /root/wp

nano docker-compose.alt.yml

docker stack deploy -c docker-compose.alt.yml <STACK_NAME>

docker service ps <SERVICE_NAME>

docker service logs <SERVICE_NAME>

cp .htaccess /mnt/wp/data
```

## Remove Wordpress and directory

```
docker service rm <SERVICE_NAME>

rm -rf /mnt/wp/data

mkdir /mnt/wp/data
```