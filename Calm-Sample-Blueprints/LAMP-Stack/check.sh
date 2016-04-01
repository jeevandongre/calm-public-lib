#!/bin/bash

http_status=`/usr/lib/nagios/plugins/check_http localhost`
PATTERN="^HTTP OK:.*$"

if [[ ! $http_status =~ $PATTERN ]]
then
http="failed"
else
http="success"
fi
PATTERN="^DISK OK.*$"
disk_status=`/usr/lib/nagios/plugins/check_disk -w 80% -c 95% -p /`
if [[ ! $disk_status =~ $PATTERN ]]
then
disk="failed"
else
disk="success"
fi
html="<html><body><center><table border=2>
<tr><td>HTTP SERVICE</td><td>$http</td></tr>
<tr><td>DISK / STATUS</td><td>$disk</td></tr>
</table></center></body></html>"
if [[ ( $http -eq 'failed' ) || ( $disk -eq 'failed' ) ]]
then
  (
echo "From: opa@calm.io "
echo "To: sarath@calm.io "
echo "MIME-Version: 1.0"
echo "Content-Type: multipart/alternative; " 
echo ' boundary="some.unique.value.ABC123/server.xyz.com"' 
echo "Subject: LAMP Health." 
echo "" 
echo "This is a MIME-encapsulated message" 
echo "" 
echo "--some.unique.value.ABC123/server.xyz.com" 
echo "Content-Type: text/html" 
echo "" 
echo "$html"
echo "------some.unique.value.ABC123/server.xyz.com--"
) | sendmail -t
fi
