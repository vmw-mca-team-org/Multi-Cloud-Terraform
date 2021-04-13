/*================
VMware Cloud on AWS SDDC
=================*/

terraform {
  required_providers {
    vmc = {
      source  = "vmware/vmc"
      version = "1.5.1"
    }
  }
}

/*================
Variables
=================*/

variable "vpc_cidr" {}
variable "sddc_name" {}
variable "sddc_region" {}
variable "aws_account_number" {}
variable "connected_vpc_subnet_1" {}
variable "vxlan_subnet" {}

data "vmc_connected_accounts" "my_accounts" {
  account_number = var.aws_account_number
}

data "vmc_customer_subnets" "my_subnets" {
  connected_account_id = data.vmc_connected_accounts.my_accounts.id
  region               = var.sddc_region
}

resource "vmc_sddc" "sddc_1" {
  sddc_name           = var.sddc_name
  vpc_cidr            = var.vpc_cidr
  num_host            = 3
  provider_type       = "AWS"
  region              = replace(upper(var.sddc_region), "-", "_")
  vxlan_subnet        = var.vxlan_subnet
  delay_account_link  = false
  skip_creating_vxlan = false
  host_instance_type  = "I3_METAL"
  deployment_type     = "SingleAZ"
  edrs_policy_type    = "storage-scaleup"
  enable_edrs         = true
  max_hosts           = 16
  min_hosts           = 3


  account_link_sddc_config {
    customer_subnet_ids  = [var.connected_vpc_subnet_1.id]
    connected_account_id = data.vmc_connected_accounts.my_accounts.id
  }

  microsoft_licensing_config {
    mssql_licensing   = "DISABLED"
    windows_licensing = "DISABLED"
  }
}
