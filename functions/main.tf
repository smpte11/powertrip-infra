variable group {}
variable location {}
variable environment {}

resource azurerm_storage_account church {
  name                     = "powertripchurchsa"
  resource_group_name      = var.group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource azurerm_app_service_plan church {
  name                = "powertripchurchsp"
  location            = var.location
  resource_group_name = var.group
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource azurerm_function_app weatherchannel {
  name                      = "powertrip-weather-channel"
  location                  = var.location
  resource_group_name       = var.group
  app_service_plan_id       = azurerm_app_service_plan.church.id
  storage_connection_string = azurerm_storage_account.church.primary_connection_string
  https_only                = true
  version                   = "~3"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME     = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "~12"
    FUNCTION_APP_EDIT_MODE       = "readonly"
  }
}

resource azurerm_function_app apigateway {
  name                      = "powertrip-api-gateway"
  location                  = var.location
  resource_group_name       = var.group
  app_service_plan_id       = azurerm_app_service_plan.church.id
  storage_connection_string = azurerm_storage_account.church.primary_connection_string
  https_only                = true
  version                   = "~3"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME     = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "~12"
    FUNCTION_APP_EDIT_MODE       = "readonly"
  }
}
