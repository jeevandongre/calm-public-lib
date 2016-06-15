Percona Blueprint
=======================

Blueprint creates a basic Percona cluster with multi master replication. By default this blueprint creates 3(All are masters) nodes.

Requirements
------------
### Provider
- Aws (Default)
- Azure
- Openstack
- Vcenter
- xenserver

Global Variables
----------
- `DB_PASSWORD` - Password for DB servers.
- `SST_USER` - SST username (replication username)
- `SST_PASS` - SST password (replication user password).
- `CLUSTER_NAME` - Name of the cluster.


Flows
-------
### Backup
Backups the database data and stores them at `backup` folder(Only in 1st master).
### Restore
Restores the database if there is any loss.By default restores latest data(Only in 1st master).
### AutoScale
Scales Up the instance by given `SCALE BY` Parameter under service policies.
### Resilience
All the Percona instances are monitored by external Nagios server. when Any instance goes down an api request is made to Calm which checks and creates new instance in place of terminated/corrupted instance.

Usage
-----
1. Upload the blueprint to calm.
2. Create a new nagios server/ or use existing.
3. Change Aws provider in overview tab, to your existing Aws settings.
4. Change in `DB_PASSWORD`,`SST_USER`,`SST_PASS`,`CLUSTER_NAME` to your desired values under global properties.
5. Change Credentials.
6. Run the deployment.

![alt text](http://p5.zdassets.com/hc/settings_assets/663149/200053878/mN1xL8tNpRRq3ws1id2YiA-calm_logo_white.png "Calm.io")
