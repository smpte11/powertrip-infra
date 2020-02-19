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

module "vnet" {
  source = "./vnet"

  group       = var.group
  location    = var.location
  environment = var.environment
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
