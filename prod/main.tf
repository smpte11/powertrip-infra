module "vnet" {
  source = "../vnet"

  group       = var.group
  location    = var.location
  environment = var.environment
}

module "k8s" {
  source = "../k8s"

  client_id     = var.client_id
  client_secret = var.client_secret

  group       = var.group
  location    = var.location
  environment = var.environment

  subnet_id = module.vnet.subnet_ids.subnet1
}
