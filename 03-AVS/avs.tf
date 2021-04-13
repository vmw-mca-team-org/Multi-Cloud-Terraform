/*================
Azure VMware Solution Variables
=================*/

variable "resource_group_name" {}
variable "resource_group_location" {}
variable "azurerm_vmware_private_cloud_management_cidr" {}
variable "azurerm_vmware_private_cloud_name" {}

/*================
Azure VMware Solution Private Cloud
=================*/

resource "azurerm_vmware_private_cloud" "avs_sddc" {
  name                = var.azurerm_vmware_private_cloud_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku_name            = "av36"

  management_cluster {
    size = 3
  }
  timeouts {
    create = "300m"
    delete = "200m"
  }

  network_subnet_cidr         = var.azurerm_vmware_private_cloud_management_cidr
  internet_connection_enabled = false
}