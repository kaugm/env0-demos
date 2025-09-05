provider "aws" {
  region = "us-east-1"
}


resource "aws_dynamodb_table" "merck-blocks-demo-table" {
  name         = "merck-blocks-demo-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S" # S for string, N for number, B for binary
  }

  # Enable DynamoDB Streams
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}


# Output the table's stream ARN
output "dynamodb_stream_arn" {
  description = "The ARN of the DynamoDB stream."
  value       = aws_dynamodb_table.merck-blocks-demo-table.stream_arn
}