# THIS FILE IS MANAGED VIA AN AUTOMATED RENDERING PROCESS. CHANGES WILL BE OVERWRITTEN.
output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets_cidr" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidr" {
  value = module.vpc.public_subnets_cidr_blocks
}

output "private_route_table" {
  value = module.vpc.private_route_table_ids
}

output "nat_gateway_ids" {
  value = module.vpc.natgw_ids
}

output "availability_zones" {
  value = module.vpc.azs
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}
