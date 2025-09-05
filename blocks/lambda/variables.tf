variable "dynamodb_stream_arn" {
  description = "The ARN of the DynamoDB stream to process."
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for the Lambda function's access."
  type        = string
}