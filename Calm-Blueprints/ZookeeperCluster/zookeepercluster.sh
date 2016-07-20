#! /bin/bash
set -ex
## Zookeep standalone verion. Installed from CDH5 apt repo. Working on Ubuntu 14.04
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y update
sudo apt-get install -y python-software-properties
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install -y oracle-java7-installer
wget https://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb
sudo dpkg -i cdh5-repository_1.0_all.deb
sudo apt-get -y update
sudo wget 'https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/cloudera.list' -O /etc/apt/sources.list.d/cloudera.list
wget https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key -O archive.key
sudo apt-key add archive.key
sudo -s <<EOF
sudo cat <<EOT >> /etc/apt/preferences.d/cloudera.pref
Package: *
Pin: release o=Cloudera, l=Cloudera
Pin-Priority: 501
EOT
EOF
sudo sudo apt-get -o Dpkg::Options::="--force-confnew" install -y zookeeper
sudo sudo apt-get -o Dpkg::Options::="--force-confnew" install -y zookeeper-server
sudo service zookeeper-server stop
sudo mkdir -p /var/lib/zookeeper
sudo chown -R zookeeper /var/lib/zookeeper
node=$((@@{calm_array_index}@@+1))
sudo service zookeeper-server init --myid=$node
nodes=$(echo "@@{calm_array_private_ip_address}@@" | tr "," "\n")
i=1
for node in $nodes; do
echo "server.${i}=${node}:2888:3888" | sudo tee -a /etc/zookeeper/conf/zoo.cfg

i=$(($i+1))
done
sudo service zookeeper-server start
