provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
  version = "1.25.0"
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}
data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "vmnetwork" {
  name          = "sddc-cgw-network-1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = var.vsphere_host
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_storage_policy" "vm_storage_policy" {
  name = "VMC Workload Storage Policy - Cluster-1"
}


resource "vsphere_content_library" "library" {
  name            = var.vsphere_cl_name
  storage_backing = [data.vsphere_datastore.datastore.id]
  description     = "A new source of content"
}

resource "vsphere_content_library_item" "win2012r2" {
  name        = var.vsphere_cl_templatename
  description = "Windows 2012 template"
  library_id  = vsphere_content_library.library.id
  file_url = "http://WebServerIP/Windows2012/windows2012.ovf"
}

resource "vsphere_virtual_machine" "dnsserver" {
  name             = var.vsphere_virtual_machine_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id = data.vsphere_host.host.id
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout = 0
  guest_id = "windows8Server64Guest"
  scsi_type = "lsilogic-sas"
  num_cpus = 2
  memory   = 4096
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "Hard disk 1"
    size  = 20
	thin_provisioned = true
	storage_policy_id = data.vsphere_storage_policy.vm_storage_policy.id
  }  
 	clone {
	  template_uuid = vsphere_content_library_item.win2012r2.id
		customize {
	    windows_options {
        computer_name  = "dnsserver"
		admin_password = "VMPassword"
		auto_logon     = true
		auto_logon_count = 1
		run_once_command_list = [
			"cmd.exe /C Powershell.exe -ExecutionPolicy Bypass Install-WindowsFeature -Name DNS -IncludeManagementTools",
			"cmd.exe /C Powershell.exe -ExecutionPolicy Bypass Add-DnsServerPrimaryZone -Name vmclab.local -ZoneFile vmclab.local.dns",
			"cmd.exe /C Powershell.exe -ExecutionPolicy Bypass Add-DnsServerResourceRecordA -Name mmdemo-host -ZoneName vmclab.local -AllowUpdateAny -IPv4Address 10.1.1.2",
			"cmd.exe /C Powershell.exe -ExecutionPolicy Bypass Add-DnsServerForwarder -IPAddress 10.1.1.1",
			"cmd.exe /C Powershell.exe -ExecutionPolicy Bypass net stop dns",
			"cmd.exe /C Powershell.exe -ExecutionPolicy Bypass net start dns"
]
      }
		network_interface {
	    ipv4_address = "10.1.1.50"
		ipv4_netmask = "24"
		dns_server_list = ["127.0.0.1"]
	  }
		ipv4_gateway = "10.1.1.1"	  
  }
}
}