MongoSharding Blueprint
=======================

Blueprint creates a Dockerswarm Cluster. By default this blueprint creates 3 node cluster, HAProxy and demo app.

Requirements
------------
### Provider
- Aws (Default)
- Azure
- Openstack

Global Variables
----------
- initial_swarm_nodes
- app_scale_up_number
- network_name
- network_subnet
- swarm_scale_up_numb
- application_tag
- initial_app_nodes

Flows
-------
###ScaleUp
Scale up application
###Scaleup
Scale up swarm cluster,number of nodes

Usage
-----
1. Upload the blueprint to calm.
2. Change Aws provider in overview tab, to your existing Aws settings.
3. Change variable in global variables.
4. Change creditals for the machine.

OUTPUT
------
1. Three node swam cluster
2. Three node docker container app
3. One Haproxy(Load balancer)

IMAGE
-----

![alt text](http://p5.zdassets.com/hc/settings_assets/663149/200053878/mN1xL8tNpRRq3ws1id2YiA-calm_logo_white.png "Calm.io")
