#!/bin/bash
set -ex

# Tell mongodb to act as a config server
sudo sed -i 's/#sharding:/sharding:\n  clusterRole: configsvr/g' /etc/mongod.conf

# Tell mongodb to be a member of a replication set
sudo sed -i 's/#replication:/replication:\n  replSetName: configReplSet/g' /etc/mongod.conf

# Start mongos and make sure it is started on reboots
COMMAND="sudo -u mongodb -b mongos --port 27018 --configdb configReplSet/config1.mongodb:27017,config2.mongodb:27017,config3.mongodb:27017 >> /var/log/mongodb/mongos.log 2>&1"
sudo sed -i "1a ${COMMAND}" /etc/rc.local
sudo su - -c "eval ${COMMAND}"
sudo service mongod restart
