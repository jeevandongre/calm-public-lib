Zookeeper Cluster Blueprint
============================
Blueprint creates a Zookeeper cluster with 3 nodes. For information on version see Release Notes below. Woks well on ubuntu 14.04.
The package is derived from cloudera cdh5. This is not derived from apache open source project.

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
### Resilience 
All the nodes of Zookeeper are monitored by any external agents.
	
Usage
-----
1. Upload the blueprint to calm.
2. Create a new Zookeeper Cluster.
3. Change Aws provider in overview tab, to your existing Aws settings.
4. Run the deployment.


Release notes 
--------------

```
version=3.4.5-cdh5.7.0
git.hash=5b80fcb040bd29037db16d3bc5a4a4583d522621
cloudera.hash=5b80fcb040bd29037db16d3bc5a4a4583d522621
cloudera.cdh.hash=e7465a27c5da4ceee397421b89e924e67bc3cbe1
cloudera.cdh-packaging.hash=8f9a1632ebfb9da946f7d8a3a8cf86efcdccec76
cloudera.base-branch=cdh5-base-3.4.5
cloudera.build-branch=cdh5-3.4.5_5.7.0
cloudera.pkg.version=3.4.5+cdh5.7.0+94
cloudera.pkg.release=1.cdh5.7.0.p0.80
cloudera.pkg.name=zookeeper
cloudera.cdh.release=cdh5.7.0
cloudera.build.time=2016.03.23-18:29:16GMT
```