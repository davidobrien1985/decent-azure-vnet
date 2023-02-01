variable "resource_group_name" {
  description = "the name of the resource group"
  type = string
}

variable "location" {
  description = "location of the resources"
  type = string
}

variable "tags" {
  description = "resource tags"
  type = map
}

variable "name_prefix" {
  description = "name prefix used for resources"
  type = string
}

variable "gatewaysubnetid" {
  description = "subnet ID used for the vnet gateway"
  type = string
}