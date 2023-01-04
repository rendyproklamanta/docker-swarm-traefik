### Each nodes
```
sudo apt update && sudo apt install software-properties-common glusterfs-server -y
sudo systemctl start glusterd
sudo systemctl enable glusterd
```

```
ssh-keygen -t rsa
sudo mkdir -p /gluster/volume
```

### Master node
```
gluster peer probe 192.168.0.1; <- IP Node Manager 1
gluster peer probe 192.168.0.2; <- IP Node Manager 2
gluster peer probe 192.168.0.3; <- IP Node Manager 3
```

```
gluster pool list
exit - Ctrl+C
```

```
sudo gluster volume create staging-gfs replica 3 192.168.0.1:/gluster/volume 192.168.0.2:/gluster/volume 192.168.0.3:/gluster/volume force
```

```
gluster volume start staging-gfs
```

### Each nodes
```
echo 'localhost:/staging-gfs /mnt glusterfs defaults,_netdev,backupvolfile-server=localhost 0 0' >> /etc/fstab

mount.glusterfs localhost:/staging-gfs /mnt

chown -R root:docker /mnt

df -h
```

### How to use
```
1. mkdir -p /mnt/mysql/data

2. Add volumes in docker compose :

    volumes:
      - type: bind
        source: /mnt/mysql/data
        target: /var/lib/mysql
```