provider "aws" {
  region = "us-west-2"
}


resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "Merck-vpc-demo-no-delete"
  }
}

output "vpc_id" {
  value = aws_vpc.main.vpc_id
}