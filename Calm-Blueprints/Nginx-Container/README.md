## Overview

This blueprint template launches an Nginx container onto an AWS EC2 instance. In order to use this blueprint template, you'll need to configure your Calm instance to use AWS Virtualization as well as Docker Repositories. You'll also need to replace parameters defined in this blueprint template to fit your specific implementation of AWS.

To use this blueprint template, download this [repository's blueprint file](./Nginx-for-Open-Source.blueprint.json) and import it as a new blueprint into your Calm instance.

The Nginx container is pulled from the official [Nginx Docker Hub library](https://hub.docker.com/_/nginx/), nginx:latest.

With a successful launch, you should be able to HTTP request the public IP of the EC2 instance on port 80 and receive the [default Nginx launch page](./default_Nginx_launch_page.png).

## Necessary Configuration

1. Calm Configuration – Setup Virtualization for AWS
2. Calm Configuraiton – Setup Repository for Docker
3. Blueprint Overview – Set Virualization
4. Blueprint Overview – Set Repository
5. Blueprint Credentials – Set private key
6. Dockerhost – Availability zone
7. Dockerhost - AMI
8. Dockerhost – VPC
9. Dockerhost – Subnet
10. Dockerhost – Security group
11. Dockerhost – Key pair

## Calm Configuration

The following changes should be made in your Calm instance's Settings page

#### Setup Virtualization for AWS

Configure your AWS Virtualization authentication such that you have full read/write priviledges on all EC2 instances. For more detail, follow the [Calm docs for setting up AWS](http://docs.calm.io/using_calm/#configuring-calm-with-amazon-web-services)

*Add the AWS provider with the Access Key ID and Secret Access Key*

*Choose your preferred availability zone*

In order to create a Docker container on an EC2 instance, Docker Engine must be installed on that instance. This installation is handled in the blueprints in the "Create" flow, via a shell script. The shell script assumes an Ubuntu 14.04 instance. We need to add the AWS Ubuntu 14.04 base AMI such that our shell script can execute correctly. At the time of this writing, the AWS supported AMI of Ubuntu 14.04 with HVM has AMI ID of fce3c696.

*Supply the proper AMI in "Favorite AMIs"*

#### Setup Repository for Docker

Configure your Docker Repository such that you have access to your private repositories, as well as public images. For more detail, follow the [Calm docs for setting up Docker](http://docs.calm.io/using_calm/#configuring-calm-with-docker)

## Blueprint

*The following changes should be made in the imported Blueprint which corresponds to this repository*

#### Overview – Set Virualization and Repository

In the "Overview" of the Blueprint (found as a tab by clicking away from any service), set your virtualization platform to the AWS configuration created above. Likewise, set the Repository to the Docker configuration created above.

#### Blueprint Credentials – Set private key

You will need to private key authentication for Calm to access the EC2 instance. For more detail, follow the [Calm docs of blueprint credentials](http://docs.calm.io/using_calm/#credentials) and [Calm docs with an example of importing a private key](http://docs.calm.io/using_calm/#example-blueprint)

*Supply a private key such that Calm can SSH into the EC2 instance*

#### Dockerhost

The "Dockerhost" is the name given to the EC2 instance that is launched by the blueprint. It is a Calm service, for which we will use as a host for the Docker container service. You should set the following parameters to be specific to your AWS implementation by clicking on the Dockerhost service in the blueprint's schematic.

##### Availability zone

*Select the AWS availability zone of your choice*

##### AMI

The script that installs Docker (viewed from the "Create" flow in the "Docker Install" task) assumes an Ubuntu 14.04 instance. 

*Choose the AMI supplied earlier in the AWS Virtualization setup*

##### VPC & Subnet

Choose the VPC and subnet that allow for open traffic. Because this is a non-proprietary image and architecture, a completely open VPC and subnet configuration is suggested.

*Choose the VPC & Subnet which allow traffic of all types and protocols	from all sources to all destinations*

##### Security group

The Calm machine SSH's onto the EC2 instance on port 22. Calm needs SSH priviledges in order to make configuration changes to the instance, as well as confirm that the instance and child processes within are functioning correction.

The Nginx container relies on receiving traffic on port 80. This is accomplished by port mapping the Dockerhost's port 80 to the Nginx container's port 80 (which should already be configured in the template).

In order for the Calm server to communicate with the Docker Engine on the Dockerhost, a designated port must be used for the [Docker Engine RESTful API](https://docs.docker.com/engine/reference/api/docker_remote_api/). This template configures port 4332 for this purpose, but this can be changed to any port that is available within the Dockerhost.

*Traffic on ports: 22, 80, and 4332 (or alternative Docker Engine port, if altered), must allow incoming traffic in their security groups*. Ports 4332 and 22 must allow traffic only from the IP of the Calm server, while port 80 must allow traffic from all incoming sources.

##### Key pair

*Use the same key pair provided in the Blueprint Credentials section*
