# Install sensu server in ubuntu 14.04 LTS. 
# Installing Redis-server 
# Installing Erlang and RabbitMq
#!/bin/bash
set -ex
wget -q http://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | sudo apt-key add -
echo "deb     http://sensu.global.ssl.fastly.net/apt sensu main" | sudo tee /etc/apt/sources.list.d/sensu.list
sudo wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb
sudo wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.0/rabbitmq-server_3.6.0-1_all.deb
sudo apt-get -y update
sudo apt-get -y install redis-server erlang-nox
sudo /etc/init.d/redis-server start
sudo update-rc.d redis-server defaults
sudo dpkg -i rabbitmq-server_3.6.0-1_all.deb
sudo update-rc.d rabbitmq-server defaults
sudo service rabbitmq-server start
sudo rabbitmqctl add_vhost /sensu
sudo rabbitmqctl add_user sensu secret
sudo rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
sudo apt-get install sensu
sudo update-rc.d sensu-server defaults
sudo update-rc.d sensu-api defaults
sudo apt-get install uchiwa
sudo mv /etc/sensu/uchiwa.json /etc/sensu/uchiwa.json.back
sudo wget https://raw.githubusercontent.com/jeevandongre/calm-public-lib/master/Calm-Blueprints/Sensu-Server/templates/uchiwa.json -P /etc/sensu/

sudo service sensu-server start
sleep 5
sudo service uchiwa start
