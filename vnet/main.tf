variable group {}
variable location {}
variable environment {}

resource azurerm_virtual_network powertrip_k8s_vnet {
  name                = "powertrip-k8s-vnet"
  location            = var.location
  resource_group_name = var.group

  address_space = ["172.0.0.0/8"]
  dns_servers   = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "k8s"
    address_prefix = "172.0.0.0/16"
  }

  tags = {
    environment = var.environment
  }
}

output k8s_subnet_ids {
  value = {
    for subnet in azurerm_virtual_network.powertrip_k8s_vnet.subnet :
    subnet.name => subnet.id
  }
}
