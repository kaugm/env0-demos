terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version >= "6.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

