variable "tags" {
  type        = map(any)
  description = "Tags to apply to AWS resources"
}

variable "mysqlport" {
  type        = number
  default     = 3306
  description = "Port for MySQL connection (default is typically 3306)"
}

variable "instance_class" {
  type        = string
  description = "Database instance type (e.g., db.r5.large)"
}

variable "autoscaling_enabled" {
  type        = bool
  description = "Whether Aurora read replica autoscaling is enabled"
}

variable "autoscaling_min_capacity" {
  type        = number
  description = "Minimum number of Aurora read replicas"
}

variable "autoscaling_max_capacity" {
  type        = number
  description = "Maximum number of Aurora read replicas"
}

variable "region" {
  type = string
  default = "us-west-2"
}

variable "ca_cert_identifier" {
  type        = string
  description = "RDS CA certificate identifier (e.g., rds-ca-rsa2048-g1)"
}

variable "engine_version" {
  type        = string
  description = "Aurora MySQL engine version (e.g., 5.7.mysql_aurora.2.11.3)"
}

variable "db_param" {
  type        = bool
  default     = false
  description = "Flag to control DB parameter group creation"
}

variable "cluster_param" {
  type        = bool
  default     = false
  description = "Flag to control Cluster parameter group creation"
}

variable "subnets" {
  type        = list(string)
  description = "Private Subnets"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "Allowed CIDRs"
}

variable "EnvironmentName" {}
variable "ApplicationName" {}