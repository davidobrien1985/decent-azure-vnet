resource "azurerm_private_dns_zone" "privatednszone" {
  for_each = toset(var.privatednszones)
  resource_group_name = var.resource_group_name
  tags = var.tags
  name = each.key
}