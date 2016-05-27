#!/bin/bash
latest_backup=$(ssh -i /tmp/key.pem -o 'StrictHostKeyChecking no' @@{calm_array_private_ip_address[0]}@@ "ls -dt $(/usr/bin/ec2metadata --local-ipv4)-*.tar.gz | head -1")
if [ $latest_backup = "" ];then
  echo "No backups available"
  exit 1
fi
STATUS=`sudo mongo  --quiet --eval 'rs.status()["members"][$(( @@{calm_array_index}@@ - $(($(( @@{calm_array_index}@@/@@{NO_OF_REPLICASETS}@@ )) * @@{NO_OF_REPLICASETS}@@))))]["stateStr"]'`
if [[ "${STATUS}" != "PRIMARY" ]]
  echo "Not a Primary server"
  exit 0
fi
scp -i /tmp/key.pem 172.0.1.23:${latest_backup} /tmp/
if [ ! -f /tmp/${latest_backup} ]; then
    echo "File ${latest_backup} not found!"
fi
tar -zxvf /tmp/${latest_backup} -C /tmp/
filename=$(basename "${latest_backup")
filename="${filename%.*.*}"
mongorestore /tmp/${filename}
