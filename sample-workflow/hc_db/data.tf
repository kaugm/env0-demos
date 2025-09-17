/*
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = var.vpc_state_key
    region = var.state_region
  }
}

data "aws_subnet" "selected" {
  for_each = toset(data.terraform_remote_state.vpc.outputs.private_subnets)
  id       = each.key
}
*/
