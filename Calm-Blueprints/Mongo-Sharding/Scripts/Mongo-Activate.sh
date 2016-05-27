#!/usr/bin/python
import os, json, subprocess, time, sys
if "@@{calm_array_index}@@" != "0":
  sys.exit(0)
replicas = int(os.environ["MONGODB_REPLICAS"])
confignodes = []

for y in range(0, replicas):
  confignodes.append({ "_id": y, "host": "config" + str(y+1) + ".mongodb" })
print subprocess.check_output("sudo mongo --host config1.mongodb --port 27017 --eval 'rs.initiate( { _id: \"configReplSet\", configsvr: true, members: " + json.dumps(confignodes) + " } )'", shell=True)

# Wait 30 sec for config servers to initiate
time.sleep(30)

for x in range(1, int(os.environ["MONGODB_SHARDS"])+1):

    host = (x-1) * replicas + 1
    nodes = []

    for y in range(0, replicas):
        nodes.append({ "_id": y, "host": "data" + str(host+y) + ".mongodb" })

    # Create the replica set for current shard
    print subprocess.check_output("sudo mongo --host data" + str(host) + ".mongodb --port 27017 --eval 'rs.initiate( { _id: \"dataReplSet" + str(x) + "\", members: " + json.dumps(nodes) + " } )'", shell=True)
time.sleep(60)
for x in range(1, int(os.environ["MONGODB_SHARDS"])+1):

    host = (x-1) * replicas + 1

    # Add current shard to the config servers
    print subprocess.check_output("sudo mongo --host config1.mongodb --port 27018 --eval 'sh.addShard( \"dataReplSet" + str(x) + "/data" + str(host) + ".mongodb:27017\" )'", shell=True)
