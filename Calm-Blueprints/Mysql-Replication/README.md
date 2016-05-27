# Mysql Replica cluster Blueprint

This blueprint creates 3 instances and configures mysql replication.
## Infra
 1. AWS
 2. Azure
 3. Openstack

##OS
 1. Ubuntu 

## Quick Start
 1. Upload the blueprint to calm
 2. Change AWS provider in overview tab
 3. Change credential `MYSQL`, under `Credentials` tab
 4. Deploy the blueprint

This uses chef-solo to install and configure mysql replication.

Username / Password : `root` / `Pass@word1`
