provider "azurerm" {
  version = "=2.2.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tstate"
    storage_account_name = "tstate32720"
    container_name       = "tstate"
    key                  = "terraform.tfstate"
  }
}

module "common" {
  source = "./common"
}

# module "vnet" {
#   source = "./vnet"

#   environment = var.environment

#   group    = module.common.group
#   location = module.common.location
# }

# module "k8s" {
#   source = "./k8s"

#   client_id     = var.client_id
#   client_secret = var.client_secret

#   environment = var.environment

#   subnet_id = module.vnet.k8s_subnet_ids.k8s

#   group    = module.common.group
#   location = module.common.location
# }

module frontend {
  source = "./frontend"

  environment = var.environment

  group    = module.common.group
  location = module.common.location
}

module church {
  source = "./functions"

  environment = var.environment

  group           = module.common.group
  location        = module.common.location
  allowed_origins = module.frontend.url
  node_env        = var.node_env
  weather_code    = var.weather_code
  darksky_key     = var.darksky_key
}
