# AWS Sandbox

A collection of exemplary code using Amazon Web Services which were mostly created learning the usage of AWS Services. All examples were created using the second version of the AWS client on linux. Steps, required to install it, are shown [here](https://docs.aws.amazon.com/de_de/cli/latest/userguide/install-cliv2.html).

## High available WebApp from External Resource with Bastion Host Access

In this example a cloud architecture is described using AWS CloudFormation. AWS EC2 server instances are created using EC2 Auto-Scaling. The source code of the web application is taken from an AWS S3 bucket hosted by the online academy Udacity to which the webservers have access to using a custom created AWS IAM role. User requests to the web application are forwarded using an Application Load Balancer. The load balancer is located in a public subnet and is permitted to forward the traffic to the private subnets where the web server reside. For outgoing traffic to the Internet the web servers are connected to a NAT gateway.
In order to allow maintenance a bastion host is generated in one of the public subnets which allows inbound SSH traffic from a specific developer IP address and has the permission to SSH into the web servers.

![Schematics of the Cloud Architecture](cloud_webapp_hosting_with_bastion_hosts/cloud_architecture.png)

In order to create this architecture, run the following command:

```
cd <path-to-repository>/cloud_webapp_hosting_with_bastion_hosts/
```

In the following the CloudFormation stacks with an arbitrary stack-name are created. Run the commands one by one, ensuring the stacks have been created successfully.
It is important to note, that the -c flag for the permission files adds IAM capabilities to the create-stack command, necessary to create an IAM Role and map it to an IAM Instance Profile.
```
../manage_stack.sh test-network cfn_network.yml parameters_network.json
../manage_stack.sh -c test-permissions cfn_permissions.yml parameters_permissions.json
../manage_stack.sh test-webservers cfn_webservers.yml parameters_webservers.json
../manage_stack.sh test-bastion-hosts cfn_bastion_hosts.yml parameters_bastion_hosts.json
```

## Simple Server with private database

This example consists of a cloud architecture designed with AWS CloudFormation. It is built around a webserver that servers a customer with a simple HTTP content. The webserver is scaled horizontally by spinning up/down virtual webserver instances depending on the requesting demand.The request load is well balanced over all webserver instances using a load balancer which forwards traffic via a public subnet to corresponding private subnets containing the "backend". The backend also contains a MySQL database which can later serve for more features of the webserver

![Schematics of the Cloud Architecture](cloud_simple_webserver_private_database/cloud_architecture.png)

In order to create this architecture, run the following command:

```
cd <path-to-repository>/cloud_simple_server_private_database/
```

In the following the CloudFormation stacks with an arbitrary stack-name are created. Run the commands one by one, ensuring the stacks have been created successfully.

```
../manage_stack.sh test-network-1 cfn_network.yml parameters_network.json
../manage_stack.sh test-webservers-1 cfn_webservers.yml parameters_webserver.json
../manage_stack.sh test-database-1 cfn_databases.yml parameters_database.json
```


## VPN Connection to the Virtual Private Cloud

This example contains of the Infrastructure-as-Code files required to set up a VPN-Connection to a given private subnet within a Virtual Private Cloud using AWS CloudFormation. This is achieved by defining the VPN connection from the client-side gateway to the virtual private gateway (VGW) within the Virtual Private Cloud (VPC)

![Schematics of the Cloud Architecture](cloud_vpn_connection_private_subnets/cloud_architecture.png)

In order to create this architecture, run the following command:

```
cd <path-to-repository>/cloud_simple_server_private_database/
```

In the following the CloudFormation stacks with an arbitrary stack-anme are created. Run the commands one by one, ensuring the stacks have been created successfully.

```
../manage_stack.sh test-network-2 cfn_network.yml parameters_network.json
```
