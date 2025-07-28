variable "name" {
  type    = string
  default = "env0-acme-ec2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc_id" {
  type = string
  default = "vpc-0c897a2a53d947af6"
}

variable "ebs_size" {
  type    = number
  default = 10
}
