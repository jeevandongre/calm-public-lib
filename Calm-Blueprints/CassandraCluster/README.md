Cassandra Cluster Blueprint
=======================

Blueprint creates Cassandra Cluster. Creates 3 node cluster.

Requirements
------------
### Provider
- Aws (Default)
- Azure
- Openstack


Flows
-------
### Backup
Backups the database data and stores them at `_BACKUP_DIR` 
### StartService
Start the services in given order.
### StopService
Stops the services.
### ScaleUp
Scales Up the instance by given `NO_OF_REPLICASETS`.
### ScaleDown
Scales Down the instance by given `NO_OF_REPLICASETS`. 
### Resilience


Usage
-----
1. Upload the blueprint to calm.
2. Create a Cassandra Cluster.
3. Change Aws provider in overview tab, to your existing Aws settings.
4. Run the deployment.


To be done 
-----------
1. Restore needs to be done.