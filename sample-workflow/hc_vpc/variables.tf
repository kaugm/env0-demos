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
  default = "us-west-2"
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
  type = map(string)
  default = {}
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

variable "EnvironmentName" {}
variable "ApplicationName" {}