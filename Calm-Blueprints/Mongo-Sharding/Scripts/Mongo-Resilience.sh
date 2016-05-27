#!/bin/bash
STATUS=`sudo mongo  --quiet --eval 'rs.status()["members"][$(( @@{calm_array_index}@@ - $(($(( @@{calm_array_index}@@/@@{NO_OF_REPLICASETS}@@ )) * @@{NO_OF_REPLICASETS}@@))))]["stateStr"]'`
if [[ "${STATUS}" != "PRIMARY" ]]
  echo "Not a Primary server"
  exit 0
fi
