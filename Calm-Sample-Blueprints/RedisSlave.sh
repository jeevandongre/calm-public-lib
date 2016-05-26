#!/bin/bash
sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo apt-get update
sudo apt-get install -y redis-server
sed -i 's/bind 127.0.0.1/#bind 127.0.0.1/' /etc/redis/redis.conf
echo "requirepass Pass@word1" | sudo tee -a /etc/redis/redis.conf
echo "masterauth Pass@word1" | sudo tee -a /etc/redis/redis.conf
echo "slaveof 10.0.1.185 6379" | sudo tee -a /etc/redis/redis.conf
sudo service redis-server restart
