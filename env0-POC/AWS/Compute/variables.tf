variable "name" {
  type    = string
  default = "env0-demo-ec2"
}

variable "instance_type" {
  type    = string
  default = "t3a.small"
}

variable "vpc_id" {
  type = string
}

variable "ebs_size" {
  type    = number
  default = 10
}
