terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

module "acme-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.1.0"

  name = var.name
  cidr = var.cidr

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = true
  one_nat_gateway_per_az = false


  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}


output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.acme-vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.acme-vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.acme-vpc.private_subnets
}

output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.acme-vpc.azs
}