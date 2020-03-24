variable location {}
variable group {}
variable environment {}

resource azurerm_storage_account frontendsa {
  name                      = "powertripfrontendsa"
  location                  = var.location
  resource_group_name       = var.group
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = "true"

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  tags = {
    environment = var.environment
  }
}

output url {
  value = azurerm_storage_account.frontendsa.primary_web_endpoint
}
