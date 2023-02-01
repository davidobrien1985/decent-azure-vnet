resource "azurerm_log_analytics_workspace" "logging" {
  name                = var.name_prefix
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_application_insights" "appinsights" {
  name                = "${var.name_prefix}-appinsights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  workspace_id = azurerm_log_analytics_workspace.logging.id
  tags = var.tags
}

output "instrumentation_key" {
  value = azurerm_application_insights.appinsights.instrumentation_key
}