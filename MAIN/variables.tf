# Multi-Cloud Lab Terraform Variables

## Azure Connection Details Variables

variable "arm_client_id" {}
variable "arm_client_secret" {}
variable "arm_subscription_id" {}
variable "arm_tenant_id" {}

## Azure Resource Group Variables

variable "resource_group_name" {}
variable "resource_group_location" {}

## Azure VMware Solution Variables

variable "azurerm_vmware_private_cloud_name" {}
variable "azurerm_vmware_private_cloud_management_cidr" {}

## Azure VNET Variables

variable "azurerm_virtual_network_address_space" {}
variable "azurerm_virtual_network_subnet_1" {}
variable "azurerm_virtual_network_name" {}

# Azure Virtual Network Gateway Variables

variable "azurerm_vng_gateway_subnet" {}

## Azure Bastion Host Variables

variable "bastion_host_subnet_cidr" {}
variable "mca_bastion_name" {}

## VMware Cloud on AWS Variables

variable "org_id" {}
variable "api_token" {}
variable "sddc_region" {}
variable "sddc_name" {}
variable "aws_account_number" {}
variable "vpc_cidr" {}
variable "vxlan_subnet" {}

## AWS Native Variables

variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_vpc_cidr" {}
variable "aws_vpc_name" {}
variable "aws_subnet_cidr_2a" {}
variable "aws_subnet_name_2a" {}
variable "aws_subnet_cidr_2b" {}
variable "aws_subnet_name_2b" {}
variable "aws_subnet_cidr_2c" {}
variable "aws_subnet_name_2c" {}
variable "aws_subnet_cidr_2d" {}
variable "aws_subnet_name_2d" {}

## Google Cloud Variable

variable "gcp_project" {}
variable "gcp_region" {}
variable "gcp_region_zone" {}
variable "gcp_network_descr" {}
variable "gcp_subnet_cidr" {}
variable "gcp_address_type" {}
variable "gcp_network_name" {}
variable "gcp_subnet_name" {}
variable "gcp_service" {}
variable "gcp_peering" {}
variable "gcp_address_purpose" {}
variable "gcp_reserved1_name" {}
variable "gcp_reserved1_address" {}
variable "gcp_reserved1_address_prefix_length" {}
variable "gcp_reserved2_name" {}
variable "gcp_reserved2_address" {}
variable "gcp_reserved2_address_prefix_length" {}

## Megaport Variables

variable "megaport_mcr_id" {}