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
### Backup
Backups the database data and stores them at `MONGO_BACKUP_PATH` in configset node 0.


Usage
-----
1. Upload the blueprint to calm.
2. Create a new cassandra server.
3. Change Aws provider in overview tab, to your existing Aws settings.
4. Run the deployment.

To be done 
-----------
1. Restore needs to be done.