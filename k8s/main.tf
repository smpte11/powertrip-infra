resource "azurerm_resource_group" "k8s" {
  name     = "day-resource"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.prefix
  dns_prefix          = var.prefix
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name


  addon_profile {
    kube_dashboard {
      enabled = "true"
    }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  agent_pool_profile {
    name            = "agentpool"
    vm_size         = "Standard_DS1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
    count           = var.agent_count
  }

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file("${var.ssh_public_key}")
    }
  }

  tags = {
    Environment = var.environment
  }
}
