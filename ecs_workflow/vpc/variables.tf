variable "name" {
  type    = string
  default = "karl-ecs-demo-vpc"
}

variable "cidr" {
  type    = string
  default = "10.5.0.0/16"
}

variable "private_subnets" {
  type    = list(any)
  default = ["10.5.1.0/24", "10.5.2.0/24"]
}

variable "public_subnets" {
  type    = list(any)
  default = ["10.5.10.0/24", "10.5.20.0/24"]
}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}
variable "region" {
  type    = string
  default = "us-east-1"
}