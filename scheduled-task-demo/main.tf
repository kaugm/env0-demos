terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.0"
    }
  }
}


provider "random" {}

resource "random_string" "example" {
  length           = 16
  special          = false
  upper            = true
  lower            = true
  number           = true
}

output "random_string_output" {
  value = random_string.example.result
}

