variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default     = "env0"
}

variable "region" {
  description = "The region where the resources are created."
  default     = "us-east-1"
}

variable "dummy" {
  description = "Dummy variable"
  default = "A"
}
