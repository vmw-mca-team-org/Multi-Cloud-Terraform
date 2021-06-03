terraform {
  required_providers {
    hcx = {
      source = "adeleporte/hcx"
    }
  }
}

provider "hcx" {
  hcx = "https://your-hcx-server.local"

  admin_username = var.hcx_admin_username
  admin_password = var.hcx_admin_password

  username = var.hcx_username
  password = var.hcx_password
}

resource "hcx_site_pairing" "cloud" {
  url      = "https://cloud-hcx-server.cloud"
  username = var.cloud_hcx_username
  password = var.cloud_hcx_password
}


resource "hcx_network_profile" "net_management" {
  site_pairing = hcx_site_pairing.cloud
  network_name = "sjc-comp-mgmt"
  name         = "sjc-comp-mgmt"
  mtu          = 1300

  ip_range {
    start_address = "172.17.31.120"
    end_address   = "172.17.31.123"
  }

  gateway       = "172.17.31.1"
  prefix_length = 24
  primary_dns   = "172.17.31.2"
  secondary_dns = "172.17.31.3"
  dns_suffix    = "tshirts.inc"
}

resource "hcx_network_profile" "net_vmotion" {
  site_pairing = hcx_site_pairing.cloud
  network_name = "sjc-comp-vmotion"
  name         = "sjc-comp-vmotion"
  mtu          = 1500

  ip_range {
    start_address = "172.17.33.120"
    end_address   = "172.17.33.123"
  }

  gateway       = "172.17.33.1"
  prefix_length = 24
  primary_dns   = "172.17.33.2"
  secondary_dns = "172.17.33.3"
  dns_suffix    = "tshirts.inc"
}

resource "hcx_compute_profile" "compute_profile_1" {
  name       = "SJC-CP"
  datacenter = "San Jose"
  cluster    = "Compute Cluster"
  datastore  = "comp-vsanDatastore"
  depends_on = [
    hcx_network_profile.net_management_gcve, hcx_network_profile.net_vmotion_gcve
  ]

  management_network  = hcx_network_profile.net_management.id
  replication_network = hcx_network_profile.net_management.id
  uplink_network      = hcx_network_profile.net_management.id
  vmotion_network     = hcx_network_profile.net_vmotion.id
  dvs                 = "nsx-overlay-transportzone"

  service {
    name = "INTERCONNECT"
  }


  service {
    name = "WANOPT"
  }

  service {
    name = "VMOTION"
  }

  service {
    name = "BULK_MIGRATION"
  }

  service {
    name = "NETWORK_EXTENSION"
  }

}

resource "hcx_service_mesh" "service_mesh_1" {
  name                   = "SJC-Interconnect-01"
  site_pairing           = hcx_site_pairing.cloud
  local_compute_profile  = "SJC-CP"
  remote_compute_profile = "Compute Profile"
  depends_on             = [hcx_compute_profile.compute_profile_1]

  app_path_resiliency_enabled   = false
  tcp_flow_conditioning_enabled = false

  uplink_max_bandwidth = 10000

  service {
    name = "INTERCONNECT"
  }

  service {
    name = "VMOTION"
  }

  service {
    name = "BULK_MIGRATION"
  }

  service {
    name = "NETWORK_EXTENSION"
  }

  service {
    name = "WANOPT"
  }

}

resource "hcx_l2_extension" "l2_extension_1" {
  site_pairing    = hcx_site_pairing.cloud
  service_mesh_id = hcx_service_mesh.service_mesh_1.id
  source_network  = "MON-Testing"
  network_type    = "NsxtSegment"
  depends_on      = [hcx_service_mesh.service_mesh_1]

  destination_t1 = "Tier1"
  gateway        = "192.168.3.1"
  netmask        = "255.255.255.0"

}