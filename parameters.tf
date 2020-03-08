locals {
  env = {
    default = {
      environment = "dev"
    }

    prod = {
      environment = "prod"
    }
  }

  envars    = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace = merge(local.env["default"], local.env[local.envars])
}
