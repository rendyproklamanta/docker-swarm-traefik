###Requirement

```
3 servers = manager (3 is minimum for fault tolerant)
2 servers = worker (optional, you can use manager only and not use worker)

NOTE: you need odd servers for fault tolerant and keep your web app running
- 3 nodes running = 1 node down
- 5 nodes running = 2 nodes down
```

###Install docker on Almalinux/CentOS

```
dnf --refresh update -y
dnf upgrade
dnf install yum-utils -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
systemctl enable docker
systemctl start docker
systemctl status docker
```

```
> Add rules :
firewall-cmd --permanent --add-port=2376/tcp
firewall-cmd --permanent --add-port=2377/tcp
firewall-cmd --permanent --add-port=7946/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --permanent --add-port=888/tcp
firewall-cmd --permanent --add-port=7946/udp
firewall-cmd --permanent --add-port=4789/udp
firewall-cmd --reload
```

###Install docker on Ubuntu

```
apt-get remove docker docker-engine docker.io
apt-get update
apt install docker.io
snap install docker
systemctl status docker
```

```
> Add rules :
ufw allow 2376/tcp
ufw allow 2377/tcp
ufw allow 7946/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 888/tcp
ufw allow 4789/udp
ufw allow 7946/udp
ufw reload
ufw enable
```

###SWAP

```
Install SWAP on Ubuntu 20.04 : https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-20-04
```

###Init docker swarm in leader node

```
docker swarm init --advertise-addr <PRIVATE_IP or PUBLIC_IP>
docker swarm join-token manager
```

###Assigned another node as swarm manager

```
> copy text from leader node and login to 2 servers for assign as manager
$ docker swarm join --token <TOKEN> <IP_LEADER>:2377
```

###Removing node from swarm (if necessary)

```
- From Master Node :
docker node ls
docker node demote <NODE_ID>
docker node rm <NODE_ID> --force

- From Removed Node :
docker swarm leave --force
```

###Install swarmpit to manage swarm

```
> login to server "Leader" manager
dnf install git (CentOS)
apt install git (Ubuntu)
git clone https://github.com/swarmpit/swarmpit -b master
docker stack deploy -c swarmpit/docker-compose.yml swarmpit
> Open swarmpit in browser http://<IP_ADDRESS>:888
```

###Run service "prune-image" to delete unused image all nodes

```
> login to server "Leader" manager
docker service create --name docker-prune --mode global --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock docker sh -c "while true; do docker image prune -af && docker container prune -f; sleep 10800; done"
> This service will automatically delete all unused images across all nodes in every 10800 secs = 3 hours
```

###Clone this repository

```
git clone https://github.com/rendyproklamanta/docker-swarm-traefik-ssl.git
```

<hr>

##Deploy traefik.yml first before deploy your app

**traefik-v1**

- _we recomend using v1 because have consul for swarm mode to share certificates accross all nodes_

```
docker network create --driver=overlay traefik-public
docker stack deploy --compose-file traefik/traefik-v1.yml traefik
> Open consul in browser http://<IP_ADDRESS>:8500
```

**traefik-v2**

- _in v2 to share certificates to all nodes need traefik enterprise edition (paid version)_

```
docker network create --driver=overlay traefik-public
docker config create traefik-tls.yml traefik/traefik-v2-tls.yml
docker stack deploy --compose-file traefik/traefik-v2.yml traefik
```

##### Note for Traefik

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

<hr>

###Create registry - Run below command one time only if you want to store docker registry in local

```
docker node update --label-add registry=true <HOSTNAME_MASTER>
docker service create --name registry --constraint 'node.labels.registry==true' --publish published=5000,target=5000 registry:latest
```

**_Build image to store in local registry_**

```
docker build -t 127.0.0.1:5000/nodejs .
docker-compose push
```

**_Check image_**

```
docker images
docker ps
```

**_Deploy stack/service (sample running nodejs)_**

```
docker stack deploy --compose-file sample/docker-compose-v1.yml mystack
```

**_Updating service_**

> Ps. before update service do build and push image

```
docker service update --image 127.0.0.1:5000/nodejs <service-name> -d
```

**_Scaling app (if necessary)_**

```
docker service scale <service-name>=5
```

**_Check services and log_**

```
docker stack ls
docker services ls
docker service logs <-f> --tail 10 <SERVICE_NAME>
```

**_Promote Worker as new Manager_**

- login to swarm leader (manager)

```
docker node ls <- will show list nodes and copy NODE_ID worker
docker node promote <NODE_ID_WORKER>
```

**_Other useful commands_**

```
> build and push to registry
docker login <= if you want to push to hub.docker.com
docker build -t <REPO_NAME> -f Dockerfile . && docker push <REPO_NAME>

> exec service bash command
docker exec -it $(docker ps -q -f name=<SERVICE_NAME>) sh

> Remove unused image and container
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
docker container prune
```

<hr>

#### Loader.io Test Result

```
3 nodes = 4000 clients / 15 seconds
4 nodes = 6000 clients / 15 seconds
```
