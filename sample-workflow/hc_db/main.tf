terraform {
  required_version = ">= 1.5.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.89.0"
    }
  }
}


provider "aws" {
  region = var.region
}

# RDS Aurora mysql
module "aurora" {
  source         = "terraform-aws-modules/rds-aurora/aws"
  version        = "7.6.0"
  name           = "${lower(var.ApplicationName)}-mysql-${lower(var.EnvironmentName)}"
  engine         = "aurora-mysql"
  engine_version = var.engine_version
  #subnets        = data.terraform_remote_state.vpc.outputs.private_subnets
  subnets = var.subnets
  vpc_id  = var.vpc_id
  #vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
  instance_class = var.instance_class
  instances = {
    one = {}
  }
  autoscaling_enabled             = var.autoscaling_enabled
  autoscaling_min_capacity        = var.autoscaling_min_capacity
  autoscaling_max_capacity        = var.autoscaling_max_capacity
  apply_immediately               = true
  skip_final_snapshot             = true
  enabled_cloudwatch_logs_exports = ["audit", "error", "slowquery"]
  #allowed_cidr_blocks             = data.terraform_remote_state.vpc.outputs.private_subnets_cidr
  allowed_cidr_blocks             = var.allowed_cidr_blocks
  deletion_protection             = true
  auto_minor_version_upgrade      = false
  storage_encrypted               = true
  performance_insights_enabled    = true
  backup_retention_period         = 35
  preferred_maintenance_window    = "sun:05:00-sun:06:00"
  db_parameter_group_name         = var.db_param ? aws_db_parameter_group.enable-8-logs.id : aws_db_parameter_group.enable-logs.id
  db_cluster_parameter_group_name = var.cluster_param ? aws_rds_cluster_parameter_group.enable-cluster-8-logs.id : aws_rds_cluster_parameter_group.enable-cluster-logs.id
  ca_cert_identifier              = var.ca_cert_identifier
  allow_major_version_upgrade     = true
  tags                            = var.tags

  # Added to help with destroys
  deletion_protection_enabled = false
}
