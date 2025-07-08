include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/ec2-instance"
}

locals {
  tfvars_file = "${get_terragrunt_dir()}/myvars.tfvars"
}

generate "tfvars" {
  path      = "terragrunt.auto.tfvars.json"
  if_exists = "overwrite_terragrunt"
  contents  = jsondecode(file(local.tfvars_file))
}
