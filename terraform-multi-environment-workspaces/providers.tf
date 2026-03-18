terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.35.1"
    }
  }
  backend "s3" {
    bucket         = "myorg-terraform-state-file-roboshop88s"
    key            = "terraform/tf-multi-env-workspaces.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }
}
provider "aws" {
  region = "us-east-1"
}