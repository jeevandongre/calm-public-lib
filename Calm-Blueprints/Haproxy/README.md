Haproxy Blueprint
=======================

Blueprint creates a basic haproxy node. We can pass the host IP's through the global properties.

Requirements
------------
### Provider
- Aws (Default)
- Azure
- Openstack

Global Variables
----------
- `HOSTS` - Mention the IP's of webservers seperated by comma. Ex: 127.0.0.1,127.0.0.2
- `PORT` - Mention the port for the webeservers.Ex: 80

Flows
-------
### Update
We can update hosts in the haproxy configuration by running this flow.
### Upgrade
We can upgrade the haproxy cookbook version by running this flow if there is new release of cookbook.

Usage
-----
1. Upload the blueprint to calm.
2. Change Aws provider in overview tab, to your existing Aws settings.
3. Change Credentials in credentials tab of global properties.
6. Run the deployment.
