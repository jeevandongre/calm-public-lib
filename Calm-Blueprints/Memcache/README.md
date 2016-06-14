
Memcached
============

Blueprint install `` php5-mysql php5 php5-memcached memcached  ``

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
2. Create a new Memcached.
3. Change Aws provider in overview tab, to your existing Aws settings.
4. Run the deployment.

TODO
-----
1. Backup 
2. Restore


OUTPUT
-------
Installs memcached on ubuntu 14.04

Image
------

![alt text](http://p5.zdassets.com/hc/settings_assets/663149/200053878/mN1xL8tNpRRq3ws1id2YiA-calm_logo_white.png "Calm.io")