#!/bin/bash
set -ex
sudo sed -i "s/#replication:/replication:\n  replSetName: dataReplSet$(((@@{calm_array_index}@@+@@{NO_OF_REPLICASETS}@@)/@@{NO_OF_REPLICASETS}@@))/g" /etc/mongod.conf
sudo service mongod restart
