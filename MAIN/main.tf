/*================
VMC Provider Authentication and Org
=================*/

provider "vmc" {
  refresh_token = var.api_token
  org_id        = var.org_id
}

/*================
GCP Project varialbes - GCP SDK will be used for authentication
=================*/

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_region_zone
}

/*================
Azure Resource Manager Connection Details and Authentication
=================*/

provider "azurerm" {
  features {}

  subscription_id = var.arm_subscription_id
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  tenant_id       = var.arm_tenant_id

  disable_correlation_request_id = true
}

/*================
AWS Connection and Authentication
=================*/

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

/*================
Megaport Connection and Authentication
=================*/

provider "megaport" {
  username = var.staging_username
  password = var.staging_password
  accept_purchase_terms = var.staging_accept_purchase_terms
  delete_ports = var.staging_delete_ports
  environment = var.staging_environment

}

/*================
Create Required AWS VPC and Subnets
=================*/

module "AWS" {
  source = "../01-AWS"

  aws_vpc_name       = var.aws_vpc_name
  aws_vpc_cidr       = var.aws_vpc_cidr
  aws_subnet_name_2a = var.aws_subnet_name_2a
  aws_subnet_name_2b = var.aws_subnet_name_2b
  aws_subnet_name_2c = var.aws_subnet_name_2c
  aws_subnet_name_2d = var.aws_subnet_name_2d
  aws_subnet_cidr_2a = var.aws_subnet_cidr_2a
  aws_subnet_cidr_2b = var.aws_subnet_cidr_2b
  aws_subnet_cidr_2c = var.aws_subnet_cidr_2c
  aws_subnet_cidr_2d = var.aws_subnet_cidr_2d
}

/*================
Create VMC SDDC
=================*/
module "VMC" {
  source = "../02-VMC"

  sddc_name              = var.sddc_name                     # SDDC Name
  vpc_cidr               = var.vpc_cidr                      # Management IP range
  connected_vpc_subnet_1 = module.AWS.connected_vpc_subnet_1 # VPC attached subnet
  sddc_region            = var.sddc_region                   # AWS region
  aws_account_number     = var.aws_account_number            # Your AWS account
  vxlan_subnet           = var.vxlan_subnet
}

/*================
Create Azure Resource Group
=================*/

module "AZURE-RG" {
  source = "../04-AZURE-RG"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location

}

/*================
Create Azure VMware Solution SDDC (Private Cloud)
=================*/

module "AVS" {
  source = "../03-AVS"

  azurerm_vmware_private_cloud_name            = var.azurerm_vmware_private_cloud_name
  resource_group_name                          = var.resource_group_name
  resource_group_location                      = var.resource_group_location
  azurerm_vmware_private_cloud_management_cidr = var.azurerm_vmware_private_cloud_management_cidr
}

/*================
Create Azure VNET
=================*/

module "VNET" {
  source = "../05-AZURE-VNET"

  azurerm_virtual_network_name          = var.azurerm_virtual_network_name
  resource_group_location               = var.resource_group_location
  resource_group_name                   = var.resource_group_name
  azurerm_virtual_network_address_space = var.azurerm_virtual_network_address_space
  azurerm_virtual_network_subnet_1      = var.azurerm_virtual_network_subnet_1
  
}

/*================
Create Azure VNET Gateway
=================*/

module "VNET-Gateway" {
  source = "../06-AZURE-VNET-GATEWAY"

  resource_group_location = var.resource_group_location
  resource_group_name = var.resource_group_name
  azurerm_virtual_network_name = var.azurerm_virtual_network_name
  azurerm_vng_gateway_subnet = var.azurerm_vng_gateway_subnet
  
}