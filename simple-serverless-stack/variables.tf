# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Input variable definitions

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "us-east-1"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "app_tier" {
  type    = string
  default = "web"
}

variable "lambda_memory_size" {
  default = 256
}

variable "lambda_timeout" {
  default = 10
}