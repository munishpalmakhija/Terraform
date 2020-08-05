# Purpose 

This terraform script will be deploy vROPS Cloud Proxy on VMC/vSphere 

# Pre-requisities 

Following are the pre-requisities
 
1.	Endpoint Details are updated in terraform.tfvars
2.	This script assumes that network selected has DHCP enabled and has outbound access as required by VMware vROPs Cloud Proxy 
3.	This script assumes that  you have network connectivity to vCenter/ESXi host where it needs to be deployed 

# Usage

Execute following commands

terraform init
terraform plan
terraform apply -auto-approve

# Contact

You can reach out to me via Twitter (@munishpal_singh) if you need further details
