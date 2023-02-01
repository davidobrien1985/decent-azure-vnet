variable "resource_group_name" {
  description = "the name of the resource group"
  type = string
}

variable "tags" {
  description = "resource tags"
  type = map
}

variable "privatednszones" {
  description = "All the private DNS zones that need to be created."
  type = list
  default = [
    "privatelink.database.windows.net",
    "privatelink.blob.core.windows.net",
    "privatelink.file.core.windows.net",
    "privatelink.vaultcore.azure.net",
    "privatelink.azurewebsites.net",
    "scm.privatelink.azurewebsites.net"
  ]
}