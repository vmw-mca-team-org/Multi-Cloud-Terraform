/*================
Outputs from Various Module
=================*/

output "connected_vpc" {value = module.AWS.connected_vpc}
output "created_mca-vnet-demo-subnet-1" {value = azurerm_virtual_network.mca-vnet-demo-subnet-1}