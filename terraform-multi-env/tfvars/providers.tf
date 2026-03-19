terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.35.1"
    }
  }
  backend "s3" {
    
  }
}
provider "aws" {
  region = "us-east-1"
}