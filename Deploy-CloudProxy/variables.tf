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

# the dipslay name of the cloudproxy. empty by default.
variable "vsphere_rdc_name" {}

# the OTK of the cloudproxy. empty by default.
variable "vsphere_rdc_otk" {}

# the password of the cloudproxy. empty by default.
variable "vsphere_rdc_password" {}