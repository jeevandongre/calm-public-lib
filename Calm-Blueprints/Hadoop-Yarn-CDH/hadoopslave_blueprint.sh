#!/bin/bash
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java8-installer
wget http://archive.cloudera.com/cdh5/one-click-install/precise/amd64/cdh5-repository_1.0_all.deb
sudo dpkg -i cdh5-repository_1.0_all.deb
## Installing Name Node on both Master and Slave nodes
sudo apt-get -y update 
sudo apt-get install -y hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce
sudo apt-get install -y hadoop-client

sudo cp -r /etc/hadoop/conf.empty /etc/hadoop/conf.my_cluster
sudo update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.my_cluster 50
sudo update-alternatives --set hadoop-conf /etc/hadoop/conf.my_cluster

sudo -u hdfs hadoop fs -mkdir /tmp
sudo -u hdfs hadoop fs -chmod -R 1777 /tmp
sudo mkdir -p /data/1/dfs/dn /data/2/dfs/dn /data/3/dfs/dn /data/4/dfs/dn
sudo chown -R hdfs:hdfs /data/1/dfs/dn /data/2/dfs/dn /data/3/dfs/dn /data/4/dfs/dn
sudo mkdir -p /data/1/yarn/local /data/2/yarn/local /data/3/yarn/local /data/4/yarn/local
sudo mkdir -p /data/1/yarn/logs /data/2/yarn/logs /data/3/yarn/logs /data/4/yarn/logs
sudo chown -R yarn:yarn /data/1/yarn/local /data/2/yarn/local /data/3/yarn/local /data/4/yarn/local
sudo chown -R yarn:yarn /data/1/yarn/logs /data/2/yarn/logs /data/3/yarn/logs /data/4/yarn/logs

sudo mv /etc/hadoop/conf/hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml.back
sudo wget https://raw.githubusercontent.com/ideadevice/calm-public-lib/master/Calm-Blueprints/Hadoop-Yarn-CDH/templates/hdfs-site.xml -P /etc/hadoop/conf/
sudo sed -i -e 's/#@#IPADDRESS#@#/@@{master_public_dns_name}@@/g' /etc/hadoop/conf/hdfs-site.xml
sudo mv /etc/hadoop/conf/core-site.xml /etc/hadoop/conf/core-site.xml.backup
sudo wget https://raw.githubusercontent.com/ideadevice/calm-public-lib/master/Calm-Blueprints/Hadoop-Yarn-CDH/templates/core-site.xml -P /etc/hadoop/conf/
sudo sed -i -e 's/#@#IPADDRESS#@#/@@{master_public_dns_name}@@/g' /etc/hadoop/conf/core-site.xml
sudo wget https://raw.githubusercontent.com/ideadevice/calm-public-lib/master/Calm-Blueprints/Hadoop-Yarn-CDH/templates/mapred-site.xml -P /etc/hadoop/conf/
sudo mv /etc/hadoop/conf/yarn-site.xml /etc/hadoop/conf/yarn-site.xml.backup
sudo wget https://raw.githubusercontent.com/ideadevice/calm-public-lib/master/Calm-Blueprints/Hadoop-Yarn-CDH/templates/yarn-site.xml -P /etc/hadoop/conf
sudo sed -i -e 's/#@#IPADDRESS#@#/@@{master_public_dns_name}@@/g' /etc/hadoop/conf/yarn-site.xml
sudo service hadoop-yarn-nodemanager start
sudo service hadoop-hdfs-datanode start