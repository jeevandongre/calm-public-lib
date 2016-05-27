#!/bin/bash
if [[ "@@{calm_array_index}@@" != "0" ]];then
  exit 0
fi

eval $(mongo --port 27018 --quiet --eval 'db.adminCommand( { listShards: 1 } )' | python -c '
import json,sys
data=json.load(sys.stdin)
print "HOST={}".format(data["shards"][len(data["shards"])-1]["host"])
')
eval $(mongo --port 27018 --quiet --eval 'db.adminCommand( { listShards: 1 } )' | python -c '
import json,sys
data=json.load(sys.stdin)
print "HOSTTOMOVE={}".format(data["shards"][@@{SHARD_TO_MOVE}@@-1]["host"])
')
host_state=`mongo --port 27018 --quiet --eval "db.adminCommand({removeShard: '${HOST}'})['state']"`
if [[ "$host_state" == "started" ]] ; then
  sleep 5
fi
host_state=`mongo --port 27018 --quiet --eval "db.adminCommand({removeShard: '${HOST}'})['state']"`
if [[ "$host_state" == "ongoing" ]] ; then
  if [[ "@@{SHARD_TO_MOVE}@@" == "" ]] ; then
    echo "Please enter the shard number value to move tables."
    exit 1
  fi
  dbstomove=`mongo --port 27018 --quiet --eval "db.adminCommand({removeShard: '${HOST}'})['dbsToMove']"`
  eval $(echo $dbstomove | python -c 'import json,sys ; data=json.load(sys.stdin) ; print "DBSTOMOVE={}".format(",".join(data))')
  for x in $(echo $DBSTOMOVE | tr "," "\n") ; do
     echo "echo moving $x"
     mongo --port 27018 --quiet --eval "db.adminCommand({ movePrimary: '$x', to: '${HOSTTOMOVE}' })"
  done
  mongo --port 27018 --quiet --eval "db.adminCommand({removeShard: '${HOST}'})"
  echo "completed removing shard '${HOST}'"
elif [[ "$host_state" == "completed" ]] ; then
  echo "Host removal completed"
fi
