resource "aws_dynamodb_table" "terraform_state" {
  name           = "terraform-staging"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-staging"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
