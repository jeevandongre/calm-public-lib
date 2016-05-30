
Rabbitmq Single Node
=======================

Blueprint installs the rabbitmq version 3.6.5 on ubuntu 14.04. It recommeded only for development mode.

Requirements
------------
### Provider
- Aws (Default)
- Azure
- Openstack


### OS
- Ubuntu 14.04

Flows
-------
### StartService
Start the services in given order.
### StopService
Stops the services.

Usage
-----
1. Upload the blueprint to calm.
2. Create a new Rabbitmq server.
3. Change Aws provider in overview tab, to your existing Aws settings.
4. Run the deployment.

TODO
-----
1. Backup needs to be done.
2. Restore needs to be done.