provider "aws" {
  region = "us-east-1"
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Tier = "public"
  }
}


# IAM role for the ECS tasks to allow them to access AWS resources.
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Sid    = "",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
    }],
  })
}

# Attach a policy to the IAM role that grants permissions for Fargate tasks.
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



# Define the task definition. This is a blueprint for our containers.
# We are using the 'awsvpc' network mode, which is required for Fargate.
resource "aws_ecs_task_definition" "nginx_task" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "${var.container_name}",
      image     = "${var.container_image}",
      cpu       = var.container_cpu,
      memory    = var.container_memory,
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80,
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# Create a security group for the ECS tasks to allow incoming HTTP traffic.
resource "aws_security_group" "ecs_tasks_sg" {
  name   = "ecs-tasks-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow inbound HTTP traffic from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

# Create the ECS service to run and maintain the tasks.
# It ensures a desired count of tasks is always running.
resource "aws_ecs_service" "nginx_service" {
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_id # aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = 1 # Number of tasks to run
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [data.aws_subnets.public.ids]
    security_groups = [aws_security_group.ecs_tasks_sg.id]
    assign_public_ip = true
  }

  tags = {
    Project = "Example-ECS-Nginx"
  }
}