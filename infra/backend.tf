terraform {
  required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.47.0"
    }
  }

  backend "s3" {
    bucket         = "shelfie-terraform-state"
    key            = "shelfie/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "shelfie-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
