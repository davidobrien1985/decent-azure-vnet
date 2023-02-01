resource "azurerm_public_ip" "vnetpip" {
  name                = "${var.name_prefix}vnetgatewaypip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Dynamic"
  tags = var.tags
}

resource "azurerm_virtual_network_gateway" "vnetgateway" {
  name                = "${var.name_prefix}vnetgateway"
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vnetpip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gatewaysubnetid
  }

  tags = var.tags
}