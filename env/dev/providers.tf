terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket  = "jm-terraform-state-demo"
    key     = "dev/us-west-2/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.region
}
