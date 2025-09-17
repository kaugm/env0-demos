resource "aws_cloudwatch_log_group" "slowquery-log-group" {
  name              = "/aws/rds/cluster/auroramysql-${lower(var.tags["EnvironmentName"])}/slowquery"
  retention_in_days = 14
  tags              = var.tags
}


resource "aws_cloudwatch_log_group" "error-log-group" {
  name              = "/aws/rds/cluster/auroramysql-${lower(var.tags["EnvironmentName"])}/error"
  retention_in_days = 14
  tags              = var.tags
}


resource "aws_cloudwatch_log_group" "general-log-group" {
  name              = "/aws/rds/cluster/auroramysql-${lower(var.tags["EnvironmentName"])}/general"
  retention_in_days = 14
  tags              = var.tags
}

resource "aws_cloudwatch_log_group" "audit-log-group" {
  name              = "/aws/rds/cluster/auroramysql-${lower(var.tags["EnvironmentName"])}/audit"
  retention_in_days = 14
  tags              = var.tags
}
