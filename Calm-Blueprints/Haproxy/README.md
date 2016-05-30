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
### Backup
Backups the database data and stores them at `MONGO_BACKUP_PATH` in configset node 0.
### Restore
Restores the database if there is any loss.By default restores latest data.
### StartService
Start the services in given order.
### StopService
Stops the services.
### Resilience
All the mongo instances are monitored by external Nagios server. when Any instance goes down an api request is made to Calm which checks and creates new instance in place of terminated/corrupted instance.

Usage
-----
1. Upload the blueprint to calm.
2. Change Aws provider in overview tab, to your existing Aws settings.
3. Change Credentials in credentials tab of global properties.
6. Run the deployment.
