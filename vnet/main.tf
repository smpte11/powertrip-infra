variable group {}
variable location {}
variable environment {}

resource azurerm_virtual_network powertrip {
  name                = "powertrip-network"
  location            = var.location
  resource_group_name = var.group

  address_space = ["10.0.0.0/16"]
  dns_servers   = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  tags = {
    environment = var.environment
  }
}

output subnet_ids {
  value = {
    for subnet in azurerm_virtual_network.powertrip.subnet :
    subnet.name => subnet.id
  }
}
