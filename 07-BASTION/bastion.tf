variable "resource_group_name" {}
variable "resource_group_location" {}
variable "mca_bastion_name" {}
variable "azurerm_virtual_network_name" {}
variable "azurerm_virtual_network_subnet_1" {}
variable "created_mca-vnet-demo-subnet-1" {}


resource "azurerm_public_ip" "mca-vnet-demo-bastion-publicIP" {
  name                = "mca-vnet-demo-bastion-publicIP"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  allocation_method = "Dynamic"
}

resource "azurerm_bastion_host" "mca-vnet-demo-bastion" {
  name                = var.mca_bastion_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.created_mca-vnet-demo-subnet-1.id
    public_ip_address_id = azurerm_public_ip.mca-vnet-demo-bastion-publicIP.id
  }
}