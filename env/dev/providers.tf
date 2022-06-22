terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  backend "s3" {
    bucket  = "jm-terraform-state-demo"
  #  dynamodb_table = "terraform-state-lock-dev-dynamo"
    key     = "dev/us-west-2/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}
