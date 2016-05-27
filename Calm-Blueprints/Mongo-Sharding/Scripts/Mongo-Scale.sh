#!/usr/bin/python
import json, sys, subprocess, time
ips='@@{calm_array_vm_machine_ip}@@'
if (len(ips.split(',')) % @@{NO_OF_REPLICASETS}@@ ) != 0:
  print "Invalid number of instances, This configuration will break"
  sys.exit(0)
nodes = []
count = 0
for i in range((((len(ips.split(','))/@@{NO_OF_REPLICASETS}@@)-1)*@@{NO_OF_REPLICASETS}@@) + 1, len(ips.split(',')) + 1 ):
  nodes.append({ "_id":  str(count) , "host": "data" + str(i) + ".mongodb" })
  count+=1

print subprocess.check_output("sudo mongo --host data" + str(((len(ips.split(','))/@@{NO_OF_REPLICASETS}@@)-1)*@@{NO_OF_REPLICASETS}@@ + 1 ) + ".mongodb --port 27017 --eval 'rs.initiate( { _id: \"dataReplSet" + str(len(ips.split(','))/@@{NO_OF_REPLICASETS}@@) + "\", members: " + json.dumps(nodes) + " } )'", shell=True)
time.sleep(30)
print subprocess.check_output("sudo mongo --host config1.mongodb --port 27018 --eval 'sh.addShard( \"dataReplSet" + str(len(ips.split(','))/@@{NO_OF_REPLICASETS}@@) + "/data" + str(((len(ips.split(','))/@@{NO_OF_REPLICASETS}@@)-1)*@@{NO_OF_REPLICASETS}@@ + 1 ) + ".mongodb:27017\" )'", shell=True)
