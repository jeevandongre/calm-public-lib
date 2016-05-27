#!/bin/bash
sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo apt-get update
sudo apt-get install -y redis-server
sudo sed -i 's/bind 127.0.0.1/#bind 127.0.0.1/' /etc/redis/redis.conf
echo "requirepass @@{PASSWORD}@@" | sudo tee -a /etc/redis/redis.conf
echo "masterauth @@{PASSWORD}@@" | sudo tee -a /etc/redis/redis.conf
echo "slaveof @@{master_ip}@@ 6379" | sudo tee -a /etc/redis/redis.conf
sudo service redis-server restart
