# resource "aws_instance" "app_server" {
#   ami           = "ami-830c94e3"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "ExampleAppServerInstance"
#   }
# }

resource "aws_s3_bucket" "tf_course" {

  bucket = "hella-buckets-of-fun-some-new-name-buh"
}

# resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
#   name = "terraform-state-lock-dynamo"
#   hash_key = "LockID"
#   read_capacity = 20
#   write_capacity = 20

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
