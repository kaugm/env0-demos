terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.41.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

variable "requester_vpc_id" {}
variable "accepter_vpc_id" {}


resource "aws_vpc_peering_connection" "example" {
  # The VPC that initiates the request
  vpc_id        = var.requester_vpc_id.id
  # The VPC that accepts the request
  peer_vpc_id   = var.accepter_vpc_id

  auto_accept   = true
  tags = {
    Name = "Requester-to-Accepter-Peering"
  }
}