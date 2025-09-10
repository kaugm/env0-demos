provider "aws" {
  region = "us-east-1"
}

# Create an ECS cluster. This is the logical grouping for our tasks.
resource "aws_ecs_cluster" "main" {
  name = "ECS-cluster-workflow-demo"
  tags = {
    Project = "ECS-cluster-workflow-demo"
    Owner = "Karl"
  }
}


# Output the DNS name of the cluster
output "ecs_cluster_id" {
  description = "The id of the ECS cluster"
  value       = aws_ecs_cluster.main.id
}

