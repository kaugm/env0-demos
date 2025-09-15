variable "instance_size" {
  description = "Azure VM Size"
  type        = string
  default = "Standard_DS2_v2"
}

variable "instance_count" {
  description = "Number of nodes in AKS cluster"
  type        = string
  default = 2
}



