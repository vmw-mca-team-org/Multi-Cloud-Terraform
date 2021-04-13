/*================
Variables
=================*/

variable "resource_group_location" {}
variable "resource_group_name" {}
variable "azurerm_virtual_network_name" {}
variable "azurerm_vng_gateway_subnet" {}


resource "azurerm_public_ip" "mca-network-gateway-public-ip-address-demo" {
  name                = "mca-network-gateway-public-ip-address-demo"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  allocation_method = "Dynamic"
}

resource "azurerm_subnet" "VNG_GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.azurerm_virtual_network_name
  address_prefixes     = var.azurerm_vng_gateway_subnet
}

resource "azurerm_virtual_network_gateway" "mca-network-gateway-demo" {
  name                = "mca-network-gateway-demo"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  type = "ExpressRoute"
  sku  = "Standard"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.mca-network-gateway-public-ip-address-demo.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.VNG_GatewaySubnet.id
  }
}