variable "region" {
  type    = string
  default = "us-east-1"
}

variable "versioning_enabled" {
    type = bool
    default = true
}

variable "bucket_name" {
    type = string
    default = "env0-demo-bucket"
}