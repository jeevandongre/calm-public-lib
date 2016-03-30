#!/bin/bash
set -ex
sudo apt-get update
consul_master_ip=@@{CONSULIP}@@
echo "DOCKER_OPTS='--cluster-store=consul://$(/usr/bin/ec2metadata --local-ipv4):8500 --cluster-advertise=eth0:2375 -H unix:///var/run/docker.sock -H=0.0.0.0:2375'" | sudo tee /etc/default/docker
sudo rm -f /etc/docker/key.json
sudo usermod -aG docker $(id -nu)
sudo service docker restart
sleep 10
sudo docker pull swarm:1.0.1
sudo docker run -d -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8400:8400 -p 8500:8500 progrium/consul -server -advertise $(/usr/bin/ec2metadata --local-ipv4) -join ${consul_master_ip}
sudo docker run -d -p 2376:2376 swarm manage -H :2376 --replication --advertise $(/usr/bin/ec2metadata --public-ipv4):2376 consul://$(/usr/bin/ec2metadata --local-ipv4):8500
sudo docker run -d  swarm join --addr=$(/usr/bin/ec2metadata --public-ipv4):2375 consul://$(/usr/bin/ec2metadata --local-ipv4):8500

