provider "azurerm" {
  version = "~>1.5"
}

terraform {
  backend "azurerm" {}
}

module "common" {
  source = "./common"

  location = var.location
}


module "prod" {
  source = "./prod"

  client_id     = var.client_id
  client_secret = var.client_secret

  location    = var.location
  environment = var.environment

  group = module.common.group_name
}
