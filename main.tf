provider "azurerm" {
  version = "~>1.23"
}

terraform {
  backend "azurerm" {}
}
