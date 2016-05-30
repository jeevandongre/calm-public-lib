Redis Master-Slave Blueprint
=======================

Blueprint creates the Redis Master-Slave nodes. 

Requirements
------------
### Provider
- Aws (Default)
- Azure
- Openstack

Global Variables
----------
- `PASSWORD` - Set the root password of the redis. Same password is replicated to master and slave.


Flows
-------
### StartService
Start the services in given order.
### StopService
Stops the services.


Usage
-----
1. Upload the blueprint to calm.
2. Create Master-Slave.
3. Change Aws provider in overview tab, to your existing Aws settings.
4. Change PASSWORD in the global variables.
5. Run the deployment.

TODO
-----
* Backup the data.
* Restore the data.