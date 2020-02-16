provider "azurerm" {
  version = "~>1.5"
}

terraform {
  backend "azurerm" {}
}


module "stage" {
  source = "./stage"

  client_id     = var.client_id
  client_secret = var.client_secret

  location    = var.location
  environment = var.environment
}
