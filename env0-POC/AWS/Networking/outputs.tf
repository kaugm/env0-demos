output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.demo-vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.demo-vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.demo-vpc.private_subnets
}

output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.demo-vpc.azs
}
