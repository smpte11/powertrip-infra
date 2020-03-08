
resource "azurerm_resource_group" "powertrip" {
  name     = "powertrip-resources"
  location = "North Europe"
}

output group {
  value = azurerm_resource_group.powertrip.name
}

output location {
  value = azurerm_resource_group.powertrip.location
}
