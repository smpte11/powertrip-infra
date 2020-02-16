module "k8s" {
  source = "../k8s"

  client_id     = var.client_id
  client_secret = var.client_secret

  location    = var.location
  environment = var.environment
}
