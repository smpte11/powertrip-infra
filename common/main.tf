variable location {}

resource "azurerm_resource_group" "powertrip" {
  name     = "powertrip-resource"
  location = var.location
}

output group_name {
  value = azurerm_resource_group.powertrip.name
}
