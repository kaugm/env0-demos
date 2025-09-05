provider "aws" {
  region = "us-east-1"
}


# Define the IAM Role for the Lambda function
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-dynamodb-stream-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}


# The Lambda function itself
resource "aws_lambda_function" "merck-blocks-demo-lambda" {
  filename         = "lambda_function_payload.zip"
  function_name    = "merck-blocks-demo-lambda"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "lambda.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
}

# The Event Source Mapping that links the Lambda to the DynamoDB stream
resource "aws_lambda_event_source_mapping" "dynamodb_stream_trigger" {
  event_source_arn  = var.dynamodb_stream_arn
  function_name     = aws_lambda_function.merck-blocks-demo-lambda.function_name
  starting_position = "LATEST"
}



output "lambda_function_arn" {
  description = "The ARN of the merck-blocks-demo-lambda function."
  value       = aws_lambda_function.merck-blocks-demo-lambda.arn
}
