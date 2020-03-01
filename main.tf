provider "azurerm" {
  version = "~>1.5"
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

  location = var.location
}

module "vnet" {
  source = "./vnet"

  location    = var.location
  environment = var.environment
  group       = module.common.group_name
}

module "k8s" {
  source = "./k8s"

  client_id     = var.client_id
  client_secret = var.client_secret

  location    = var.location
  environment = var.environment

  subnet_id = module.vnet.subnet_ids.subnet1

  group = module.common.group_name
}
