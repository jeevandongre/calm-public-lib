#! /bin/bash
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
sudo apt-get install -y cassandra