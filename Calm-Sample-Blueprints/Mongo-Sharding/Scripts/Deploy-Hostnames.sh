#!/bin/bash
cat > /tmp/set-hostnames.py <<EOF
#!/usr/bin/python
import re
config_ips="@@{CONFIG_IP_SET}@@"
data_ips="DATA_IP_SET"

hostfile = open('/etc/hosts', 'r').read()

# Remove all current mongodb references
print hostfile
hostfile = re.sub('\n#MONGODB-BEGIN.*?#MONGODB-END', '', hostfile, flags=re.DOTALL)

# Add a placeholder for mongodb hosts
hostfile += "#MONGODB-BEGIN\n"

# Loop through all global variables and substract all mongodb hosts and IPs
count=1
for ip in config_ips.split(','):
  hostfile += ip + " config" + str(count) + ".mongodb\n"
  count += 1
count=1
for ip in data_ips.split(','):
  hostfile += ip + " data" + str(count) + ".mongodb\n"
  count += 1
# Close the list of mongodb hosts
hostfile += "#MONGODB-END\n"

# Save the results back to the hosts file
open('/etc/hosts', 'w').write(hostfile)
EOF
sudo python /tmp/set-hostnames.py
