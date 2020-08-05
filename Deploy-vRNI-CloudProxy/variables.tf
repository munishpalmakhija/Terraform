# vsphere login account. defaults to admin account
variable "vsphere_user" {
  default = "mmakhija@vmware.com"
}

# vsphere account password. empty by default.
variable "vsphere_password" {}

# vsphere server, defaults to localhost
variable "vsphere_server" {
  default = "localhost"
}

# vsphere datacenter the virtual machine will be deployed to. empty by default.
variable "vsphere_datacenter" {}

# vsphere resource pool the virtual machine will be deployed to. empty by default.
variable "vsphere_resource_pool" {}

# vsphere datastore the virtual machine will be deployed to. empty by default.
variable "vsphere_datastore" {}

# vsphere network the virtual machine will be connected to. empty by default.
variable "vsphere_network" {}

# vsphere host the virtual machine will be connected to. empty by default.
variable "vsphere_host" {}

# the name of the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_name" {}

# ip of the cloudproxy. empty by default.
variable "vsphere_rdc_ip" {}

# netmask of the cloudproxy. empty by default.
variable "vsphere_rdc_netmask" {}

# gateway of the cloudproxy. empty by default.
variable "vsphere_rdc_gateway" {}

# dns of the cloudproxy. empty by default.
variable "vsphere_rdc_dns" {}

# domainsearch of the cloudproxy. empty by default.
variable "vsphere_rdc_domainsearch" {}

# ntp of the cloudproxy. empty by default.
variable "vsphere_rdc_ntp" {}

# sshpassword of the cloudproxy. empty by default.
variable "vsphere_rdc_sshpassword" {}

# clipassword of the cloudproxy. empty by default.
variable "vsphere_rdc_clipassword" {}

# the OTK of the cloudproxy. empty by default.
variable "vsphere_rdc_otk" {}
