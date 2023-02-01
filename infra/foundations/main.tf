# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  backend "local" {}
  
  required_version = ">= 1.3.7"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "foundations" {
  name = "decentstuff"
  location = local.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name_prefix}vnet"
  location            = azurerm_resource_group.foundations.location
  resource_group_name = azurerm_resource_group.foundations.name
  address_space       = ["10.0.0.0/16"]
  tags = local.common_tags
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnet
  name                 = each.value["name"]
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value["address_prefixes"]
  depends_on           = [azurerm_virtual_network.vnet]
}

module logging {
  source = "./modules/logging"
  resource_group_name = azurerm_resource_group.foundations.name
  location            = azurerm_resource_group.foundations.location
  tags = local.common_tags
  name_prefix = local.name_prefix
}

locals {
  subnets = {
    for key, value in azurerm_subnet.subnet : key => value
  }
}

module "networkgateways" {
  source = "./modules/networkgateways"
  resource_group_name = azurerm_resource_group.foundations.name
  location            = azurerm_resource_group.foundations.location
  tags = local.common_tags
  name_prefix = local.name_prefix
  gatewaysubnetid = (lookup(local.subnets, "gateway_subnet", "not_found")).id
}

module "privatedns" {
  source = "./modules/dns"
  resource_group_name = azurerm_resource_group.foundations.name
  tags = local.common_tags
}