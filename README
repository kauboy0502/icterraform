Terraform Assignment
Prerequisite:

You should have access to AWS cloud (test environment). Install and configure the awscli. Use least possible configuration while creating resources. Delete the resources as soon as you are done with the assignment.

Lab Instructions:

Find the latest stable version available for terraform at the time when you are performing this assignment, and configure it on your local system. Create below resources as per the required setup.

Divide your code in separate files/directories as per this format:
Modules folder - which will contain the code for each of the resource we are going to create
provider.tf - provider and backend configuration
outputs.tf - should contain the outputs (information which we want the user to get back after each terraform run)
vars.tf - Should only contain the variable declarations
main.tf - which will contain the code to call a specific module Write terraform code to create below architecture by following terraform best practices:
VPC and networking details: Create VPC with 3 private and 3 public subnets. Create NAT gateway, internet gateway and route tables such that the instances in the public subnet should be able to access the internet directly through the internet gateway and anyone from outside should be able to access the instance in public subnet if security group allows. Resources in private subnet should not be accessible from outside of the VPC directly but at the same time resources within the private subnet should be able to access the internet via NAT gateway, ie for resources in private subnet, inbound connections from outside of VPC should not be allowed, but outbound connections from within the subnet should be allowed as we route them via NAT instance. Create all networking related components in one module.
For EC2
Inbound - allow port 22 access from specific IPs which are whitelisted.
Outbound - rules - All allowed.
For RDS
Inbound* - port 5432 (PostgreSQL) for SG that was created for EC2.
Outbound rules - All allowed.
Create below resources with the help of their separate terraform modules. Create your own modules, don't use terraform modules from documentation / community.
RDS instance - PostgreSQL with minimum hardware (should be within free tier). RDS should be created within private subnets.
EC2 instance - Linux t2.micro instance should be in public subnet. Also, create a public / private key pair for authentication over SSH.
VPC components - as stated in point 1.
Note: You must not hardcode your AWS credentials in git repo / terraform code. State lock feature is not mandatory to be used, but use the remote state storage.
