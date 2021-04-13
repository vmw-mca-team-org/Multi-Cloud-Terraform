/*================
Azure VNET Variables
=================*/

variable "resource_group_location" {}
variable "resource_group_name" {}
variable "azurerm_virtual_network_address_space" {}
variable "azurerm_virtual_network_subnet_1" {}
variable "azurerm_virtual_network_name" {}

/*================
Azure VNET
=================*/

resource "azurerm_virtual_network" "mca-vnet-demo" {
  name                = var.azurerm_virtual_network_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.azurerm_virtual_network_address_space

  subnet {
    name           = "mca-vnet-demo-subnet-1"
    address_prefix = var.azurerm_virtual_network_subnet_1
  }
}

/*================
Output
=================*/

output "created_mca-vnet-demo-subnet-1" {value = azurerm_virtual_network.mca-vnet-demo.subnet[0]}