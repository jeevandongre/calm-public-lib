Cassandra Single Node
=======================

Blueprint create a Cassandra single node server. Recommended to use this configuration only in development mode.
Not recommended for production mode.

Requirements
------------
### Provider
- Aws (Default)
- Azure
- Openstack

Flows
-------
### StartService
Start the services in given order.
### StopService
Stops the services.

Usage
-----
1. Upload the blueprint to calm.
2. Create a new Cassandra server.
3. Change Aws provider in overview tab, to your existing Aws settings.
4. Run the deployment.

TODO
-----
1. Backup needs to be done.
2. Restore needs to be done.