# Start of the block one #
#!/bin/bash
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y update
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install -y oracle-java7-installer
wget http://archive.cloudera.com/cdh5/one-click-install/precise/amd64/cdh5-repository_1.0_all.deb
sudo dpkg -i cdh5-repository_1.0_all.deb
sudo wget 'https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/cloudera.list' -O /etc/apt/sources.list.d/cloudera.list
wget https://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key -O archive.key
sudo apt-key add archive.key
echo "Package: *
Pin: release o=Cloudera, l=Cloudera
Pin-Priority: 501" |  sudo  tee -a /etc/apt/preferences.d/cloudera.pref
sudo apt-get -y update 
sudo apt-get install -y zookeeper
sudo apt-get install -y zookeeper-server
mkdir -p /var/lib/zookeeper
sudo chown -R zookeeper /var/lib/zookeeper/
sudo service zookeeper-server init
sudo service zookeeper-server start
## Installing Name Node on both Master and Slave nodes
sudo apt-get install -y hadoop-hdfs-namenode hadoop-client
## Do not install Secondary name node for HA
#sudo apt-get install -y hadoop-mapreduce-historyserver hadoop-yarn-proxyserver
sudo cp -r /etc/hadoop/conf.empty /etc/hadoop/conf.my_cluster
sudo update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.my_cluster 50
sudo update-alternatives --set hadoop-conf /etc/hadoop/conf.my_cluster
sudo mkdir -p /data/1/dfs/nn /nfsmount/dfs/nn
sudo chown -R hdfs:hdfs /data/1/dfs/nn /nfsmount/dfs/nn
sudo chmod 700 /data/1/dfs/nn /nfsmount/dfs/nn
sudo chmod go-rx /data/1/dfs/nn /nfsmount/dfs/nn
## File Operation
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
## Update hdfs-site.xml
sudo -u hdfs hdfs namenode -format
sudo service hadoop-hdfs-namenode start
sudo -u hdfs hadoop fs -mkdir -p /var/log/hadoop-yarn
sudo -u hdfs hadoop fs -chown yarn:mapred /var/log/hadoop-yarn
sudo apt-get install hadoop-yarn-resourcemanager
# Start of the block two  #
sudo service hadoop-yarn-resourcemanager start
sudo -u hdfs hadoop fs -mkdir -p /user/history
sudo -u hdfs hadoop fs -chmod -R 1777 /user/history
sudo -u hdfs hadoop fs -chown mapred:hadoop /user/history
sudo apt-get install hadoop-mapreduce-historyserver hadoop-yarn-proxyserver
sudo service hadoop-mapreduce-historyserver start
