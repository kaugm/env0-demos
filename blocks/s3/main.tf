terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# The random_pet resource generates a unique, human-readable name.
resource "random_pet" "bucket_suffix" {
  length = 2
}

resource "aws_s3_bucket" "my_simple_bucket" {
  bucket = "merck-blocks-demo-${random_pet.bucket_suffix.id}"
}

# An output to show the generated bucket name
output "s3_bucket_name" {
  description = "The unique name of the S3 bucket."
  value       = aws_s3_bucket.my_simple_bucket.bucket
}