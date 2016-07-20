#!/bin/bash
set -x
sudo apt-get -y install software-properties-common python-software-properties
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -y update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java8-installer
wget http://mirror.fibergrid.in/apache/lucene/solr/6.1.0/solr-6.1.0.tgz
tar xzf solr-6.1.0.tgz solr-6.1.0/bin/install_solr_service.sh --strip-components=2
sudo bash ./install_solr_service.sh solr-6.1.0.tgz

