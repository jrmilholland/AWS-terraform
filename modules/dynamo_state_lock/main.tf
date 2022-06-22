locals {
  dynamo_table_name = var.dynamo_table_name
}

resource "aws_dynamodb_table" "dynamodb_terraform_state_lock" {
  name           = local.dynamo_table_name
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}