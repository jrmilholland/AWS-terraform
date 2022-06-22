terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  backend "s3" {
    bucket         = "jm-terraform-state-demo"
#    dynamodb_table = "terraform-state-lock-dev-dynamo" // Cannot be a variable, comment before dynamo is created
    key            = "dev/us-west-2/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

# resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
#   name           = "terraform-state-lock-dev-dynamo"
#   hash_key       = "LockID"
#   read_capacity  = 20
#   write_capacity = 20

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

module "dynamo_state_lock" {
  source                   = "../../modules/dynamo_state_lock"
  dynamo_table_name = "terraform-state-lock-dev-dynamo" // This has to match dynamo_table in the backend
}