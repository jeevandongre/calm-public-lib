#!/bin/bash
sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo apt-get update
sudo apt-get install -y redis-server
sudo sed -i 's/tcp-keepalive 0/tcp-keepalive 60/' /etc/redis/redis.conf
sudo sed -i 's/bind 127.0.0.1/#bind 127.0.0.1/' /etc/redis/redis.conf
echo "requirepass @@{PASSWORD}@@" | sudo tee -a /etc/redis/redis.conf
echo "maxmemory-policy noeviction" | sudo tee -a /etc/redis/redis.conf
sudo sed -i 's/appendonly no/appendonly yes/' /etc/redis/redis.conf
sudo sed -i 's/appendfilename "appendonly.aof"/appendfilename redis-staging-ao.aof/' /etc/redis/redis.conf
sudo service redis-server restart
