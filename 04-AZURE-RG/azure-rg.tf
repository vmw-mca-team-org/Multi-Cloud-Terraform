variable "resource_group_name" {}
variable "resource_group_location" {}

resource "azurerm_resource_group" "avs_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
  
}

/*================
Outputs variables for other modules to use
=================*/

output "created_resource_group_location" {value = azurerm_resource_group.avs_resource_group.location}
output "created_resource_group_name" {value = azurerm_resource_group.avs_resource_group.name}