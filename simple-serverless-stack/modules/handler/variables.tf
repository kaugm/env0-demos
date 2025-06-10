variable "memory_size" {
  type    = number
  default = 128
}

variable "timeout" {
  type    = number
  default = 3
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}