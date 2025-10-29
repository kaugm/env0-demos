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

variable "requester_vpc_id" {}
variable "accepter_vpc_id" {}


resource "aws_vpc_peering_connection" "example" {
  # The VPC that initiates the request
  vpc_id        = var.requester_vpc_id
  # The VPC that accepts the request
  peer_vpc_id   = var.accepter_vpc_id

  auto_accept   = true
  tags = {
    Name = "Requester-to-Accepter-Peering"
  }
}

resource "aws_route" "requester_route" {
  # Change this to your specific route table ID if not using the main one
  # route_table_id            = var.requester_vpc_id.main_route_table_id
  # Destination CIDR block of the Accepter VPC
  destination_cidr_block    = "10.85.0.0/16"
  # The ID of the VPC peering connection
  vpc_peering_connection_id = aws_vpc_peering_connection.example.id
}

resource "aws_route" "accepter_route" {
  # Change this to your specific route table ID if not using the main one
  # route_table_id            = var.accepter_vpc_id.main_route_table_id
  # Destination CIDR block of the Requester VPC
  destination_cidr_block    = "10.84.0.0/16"
  # The ID of the VPC peering connection
  vpc_peering_connection_id = aws_vpc_peering_connection.example.id
}