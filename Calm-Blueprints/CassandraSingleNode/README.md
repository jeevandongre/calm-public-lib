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
1. Upload the blueprint to Calm.
2. Change Aws provider in overview tab, to your existing Aws settings.
3. Run the deployment.

Output
------
1. Spins a single node cassandra server. 

