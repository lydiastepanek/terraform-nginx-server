provider "aws" {
  profile = "home"
  version = "1.51.0"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "terraform-nginx-state-storage" {
  bucket = "terraform-nginx-state-storage"

  versioning {
    enabled = true
  }

  tags {
    Name = "Remote Terraform State Store"
  }
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
