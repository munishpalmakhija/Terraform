provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"
 
  # If you have a self-signed cert
  allow_unverified_ssl = true
}
 
data "vsphere_datacenter" "datacenter" {
  name = "${var.vsphere_datacenter}"
}
 
data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
 
data "vsphere_resource_pool" "pool" {
  name          = "${var.vsphere_resource_pool}"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
 
data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "host" {
  name          = "${var.vsphere_host}"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "cloudproxy" {
  name = "${var.vsphere_virtual_machine_name}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id = data.vsphere_datastore.datastore.id
  datacenter_id = data.vsphere_datacenter.datacenter.id
  host_system_id = data.vsphere_host.host.id
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout = 0
 
  ovf_deploy {
    remote_ovf_url = "https://ci-data-collector.s3.amazonaws.com/VMware-Cloud-Services-Data-Collector.ova"
    disk_provisioning = "thin"
    ovf_network_map = {
        "Network 1" = data.vsphere_network.network.id
    }
  }
 
  vapp {
    properties = {
      "ONE_TIME_KEY" = "${var.vsphere_rdc_otk}",
      "rdc_name" = "${var.vsphere_rdc_name}",
      "itfm_root_password" = "${var.vsphere_rdc_password}"
    }
  }
}