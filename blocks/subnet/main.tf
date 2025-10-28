terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.az
  map_public_ip_on_launch = true # Required for public access
  tags = {
    Name = "Merck-demo-subnet"
  }
}

output "public_subnet_id"{
  value = aws_subnet.public.id
}