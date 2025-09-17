variable "vpc_azs" {
  type = list(any)
}

variable "vpc_private_subnets" {
  type = list(any)
}

variable "vpc_public_subnets" {
  type = list(any)
}

variable "vpc_cidr" {
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "tags" {
  type = map(any)
}

variable "create_igw" {
  type    = bool
  default = true
}

variable "default_vpc_enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "default_vpc_enable_dns_support" {
  type    = bool
  default = true
}
