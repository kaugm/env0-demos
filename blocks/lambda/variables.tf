variable "dynamodb_stream_arn" {
  description = "The ARN of the DynamoDB stream to process."
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for the Lambda function's access."
  type        = string
  default = "dummy_bucket"
}

variable "function_package" {
  description = "Name of ZIP archive containing function code."
  type        = string
  default     = "lambda_function_payload.zip"
}


