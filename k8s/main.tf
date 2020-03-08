resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.prefix
  dns_prefix          = var.prefix
  location            = var.location
  resource_group_name = var.group


  addon_profile {
    kube_dashboard {
      enabled = "true"
    }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  default_node_pool {
    name           = "${var.prefix}k8s"
    vm_size        = "Standard_DS1_v2"
    node_count     = var.agent_count
    vnet_subnet_id = var.subnet_id
  }

  tags = {
    Environment = var.environment
  }
}
