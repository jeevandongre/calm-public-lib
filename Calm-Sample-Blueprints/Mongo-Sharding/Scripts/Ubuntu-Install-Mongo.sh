#!/bin/bash
set -ex

# Set default values
: ${MONGODB_VERSION:="3.2.3"}
: ${MONGODB_PATH:="/mnt/mongodb"}

# Add mongodb repository
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee -a /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update

# Install mongodb packages
sudo apt-get install -y mongodb-org=${MONGODB_VERSION} mongodb-org-server=${MONGODB_VERSION} mongodb-org-shell=${MONGODB_VERSION} mongodb-org-mongos=${MONGODB_VERSION} mongodb-org-tools=${MONGODB_VERSION}

# Make sure mongodb does not get updated automatically
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

# Prepare the path for the databases
sudo mkdir -p ${MONGODB_PATH}
sudo chown mongodb:mongodb ${MONGODB_PATH}

# Disable huge mem pages
sudo sed -i '/pre-start script/a echo "never" > /sys/kernel/mm/transparent_hugepage/enabled; echo "never" > /sys/kernel/mm/transparent_hugepage/defrag' /etc/init/mongod.conf

# Enable mongodb to listen for remote connections
sudo sed -i 's/bindIp:/#bindIp:/g' /etc/mongod.conf

# Tell mongodb where to store database files
sudo sed -i "s#/var/lib/mongodb#${MONGODB_PATH}#g" /etc/mongod.conf
