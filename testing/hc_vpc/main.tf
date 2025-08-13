terraform {
  required_version = ">= 0.13.1"
  required_providers {
    aws = "~> 4.0"
  }
}

provider "aws" {
  region = "us-west-2"
  ignore_tags {
    key_prefixes = ["kubernetes.io/"]
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source                           = "terraform-aws-modules/vpc/aws"
  version                          = "3.18.1"
  name                             = "${lower(var.tags["ApplicationName"])}-${lower(var.tags["EnvironmentName"])}"
  cidr                             = var.vpc_cidr
  azs                              = var.vpc_azs
  private_subnets                  = var.vpc_private_subnets
  public_subnets                   = var.vpc_public_subnets
  enable_dns_hostnames             = true
  enable_dns_support               = true
  enable_nat_gateway               = var.enable_nat_gateway
  single_nat_gateway               = var.single_nat_gateway
  create_igw                       = var.create_igw
  default_vpc_enable_dns_hostnames = var.default_vpc_enable_dns_hostnames
  default_vpc_enable_dns_support   = var.default_vpc_enable_dns_support
  tags                             = var.tags
}
