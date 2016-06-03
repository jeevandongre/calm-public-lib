#!/bin/sh
#This script is made for the calm appilication high availabiity solution
#This should be run as cron job on primary instance

#Pre-requesties for this script
#We need check the ssh connection between the primary and secondary instances
#We need provide the filename and path to be created secondary instance for postgresql failover in case of any failures in the primary instance
#Specify all the variable values

SERVICE1='db:redis'
SERVICE2='calm:styx'
USER='root'
IP='13.92.131.176'
FILE_LOCATION='/opt/calmio/var/lib/postgresql/9.3/main/failover2.txt'

if [ `supervisorctl status |grep $SERVICE1 | grep STOPPED | wc -l` -eq "0" ]
then
  if [ `supervisorctl status |grep $SERVICE2 | grep STOPPED | wc -l` -eq "0" ]
  then
    echo "$SERVICE1,$SERVICE2 are running"
  else
    echo "$SERVICE2  is down"
    supervisorctl stop $SERVICE1
    ssh $USER@$IP "touch $FILE_LOCATION"
  fi
else
    echo "$SERVICE1 is down"
    supervisorctl stop $SERVICE2
    ssh $USER@$IP "touch $FILE_LOCATION"
fi
