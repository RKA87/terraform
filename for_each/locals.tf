locals {
  env = "dev"
  common_tags = {
    proj        = "roboshop"
    environment = local.env
    owner       = "rakesh"
    terraform   = "true"
  }
}