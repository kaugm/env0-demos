variable "task_family" {
  description = "Task family (label)"
  type        = string
  default = ""
}

variable "cpu" {
  description = "vCPU resources allowed for entire task"
  type        = number
  default = 256
}

variable "memory" {
  description = "RAM resources allowed for entire task"
  type        = number
  default = 512
}

variable "container_name" {
  description = "Unique name for container"
  type        = string
  default = ""
}

variable "container_image" {
  description = "Image for container"
  type        = string
  default = "nginx:latest"
}

variable "container_cpu" {
  description = "vCPU resources reserved for container"
  type        = string
  default = "128"
}

variable "container_memory" {
  description = "RAM resources reserved for container"
  type        = string
  default = "256"
}

variable "ecs_service_name" {
  description = "ECS service to maintain task."
  type        = string
  default = ""
}

variable "ecs_cluster_id" {
  description = "ID of ECS cluster"
  type        = string
  default = ""
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
