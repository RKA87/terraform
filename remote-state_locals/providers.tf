terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.35.1"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "path/to/my/terraform.tfstate"
    region         = "us-east-1"
    # Optional: Enable state locking with DynamoDB
    dynamodb_table = "terraform-state-locks"
    # Optional: Enable server-side encryption
    encrypt        = true
  }
}
provider "aws" {
  region = "us-east-1"
}