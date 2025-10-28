provider "aws" {
  region = "us-west-2"
}

resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.az
  map_public_ip_on_launch = true # Required for public access
  tags = {
    Name = "public-subnet-1a"
  }
}