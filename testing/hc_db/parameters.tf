##############################8.0#######################################
resource "aws_db_parameter_group" "enable-8-logs" {
  name        = "enable-8-logs-parameter-group"
  family      = "aurora-mysql8.0"
  description = "Enabling mysql8.0 logs"
  tags        = var.tags

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "log_queries_not_using_indexes"
    value = "1"
  }

  parameter {
    name  = "log_output"
    value = "FILE"
  }

  parameter {
    name  = "long_query_time"
    value = "10"
  }

  parameter {
    name  = "max_allowed_packet"
    value = "268435456"
  }

}

resource "aws_rds_cluster_parameter_group" "enable-cluster-8-logs" {
  name        = "enable-cluster-8-logs-parameter-group"
  family      = "aurora-mysql8.0"
  description = "Enabling Cluster mysql8.0 level logs"
  tags        = var.tags

  parameter {
    name  = "server_audit_events"
    value = "CONNECT"
  }

  parameter {
    name  = "server_audit_logging"
    value = "1"
  }
}

####################################5.7##################################################
resource "aws_db_parameter_group" "enable-logs" {
  name        = "enable-logs-parameter-group"
  family      = "aurora-mysql5.7"
  description = "Enabling logs"
  tags        = var.tags

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "log_queries_not_using_indexes"
    value = "1"
  }

  parameter {
    name  = "log_output"
    value = "FILE"
  }

  parameter {
    name  = "long_query_time"
    value = "10"
  }

  parameter {
    name  = "max_allowed_packet"
    value = "268435456"
  }

}

resource "aws_rds_cluster_parameter_group" "enable-cluster-logs" {
  name        = "enable-cluster-logs-parameter-group"
  family      = "aurora-mysql5.7"
  description = "Enabling Cluster level logs"
  tags        = var.tags

  parameter {
    name  = "server_audit_events"
    value = "CONNECT"
  }

  parameter {
    name  = "server_audit_logging"
    value = "1"
  }
}
#####################################################################
