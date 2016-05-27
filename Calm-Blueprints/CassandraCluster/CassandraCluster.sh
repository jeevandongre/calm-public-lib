#! /bin/bash
sudo apt-get install -y gcc
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java8-installer
sudo echo "deb http://www.apache.org/dist/cassandra/debian 35x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
sudo echo "deb-src http://www.apache.org/dist/cassandra/debian 35x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
gpg --export --armor F758CE318D77295D | sudo apt-key add -
gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00
gpg --export --armor 2B5C1B00 | sudo apt-key add -
gpg --keyserver pgp.mit.edu --recv-keys 0353B12C
gpg --export --armor 0353B12C | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -o Dpkg::Options::="--force-confnew" install -y cassandra
sudo service cassandra stop
sudo rm -rf /var/lib/cassandra/data/system/*
sudo sed -i 's/cluster_name: \x27Test Cluster\x27/cluster_name: \x27calm\x27/' /etc/cassandra/cassandra.yaml
sudo sed -i 's#- seeds: "127.0.0.1"#- seeds: "@@{calm_array_private_ip_address}@@"#' /etc/cassandra/cassandra.yaml
sudo sed -i 's/listen_address: localhost/listen_address: @@{private_ip_address}@@/' /etc/cassandra/cassandra.yaml
sudo sed -i 's/rpc_address: localhost/rpc_address: \x27127.0.0.1\x27/' /etc/cassandra/cassandra.yaml
sudo sed -i 's/endpoint_snitch: SimpleSnitch/endpoint_snitch: GossipingPropertyFileSnitch/' /etc/cassandra/cassandra.yaml
echo "auto_bootstrap: true" | sudo tee -a /etc/cassandra/cassandra.yaml
sudo service cassandra start