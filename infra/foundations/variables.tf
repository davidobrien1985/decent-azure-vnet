variable "subnet" {
  description = "Map of Azure VNET subnet configuration"
  type        = map(any)
  default = {
    bastion_subnet = {
      name                 = "AzureBastionSubnet"
      address_prefixes     = ["10.0.1.0/26"]
    },
    gateway_subnet = {
      name                 = "GatewaySubnet"
      address_prefixes     = ["10.0.1.64/26"]
    }
    appgateway_subnet = {
      name                 = "ApplicationGatewaySubnet"
      address_prefixes     = ["10.0.2.0/26"]
    }
    forensicregisterapi_subnet = {
      name                 = "app"
      address_prefixes     = ["10.0.3.0/27"]
    }
    data_subnet = {
      name                 = "data"
      address_prefixes     = ["10.0.3.32/27"]
    }
  }
}