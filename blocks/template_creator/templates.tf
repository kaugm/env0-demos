terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

provider "env0" {
  api_key    = var.ENV0_KEY_ID
  api_secret = var.ENV0_KEY_SECRET
}

# Pull in Env0 Credentials
variable "ENV0_KEY_ID" {
  description = "Env0 API key"
  type        = string
}

variable "ENV0_KEY_SECRET" {
  description = "Env0 API secret"
  type        = string
}

# Pull Project ID
data "env0_project" "karl_project" {
  name = "Karl"
}

# TEMPLATE 1: VPC
resource "env0_template" "Merck-Demo-VPC" {
  name              = "Merck-Demo-VPC"
  repository        = "https://github.com/kaugm/env0-demos"
  path              = "blocks/vpc"
  type              = "terraform"
  revision          = "main"
  terraform_version = "RESOLVE_FROM_TERRAFORM_CODE"
  github_installation_id = 61344253
}

resource "env0_template_project_assignment" "merck-vpc-assignment" {
  template_id = env0_template.Merck-Demo-VPC.id
  project_id  = data.env0_project.karl_project.id
}

output "merck_vpc_template_id" {
  value = env0_template.Merck-Demo-VPC.name
}


# TEMPLATE 2: SUBNET
resource "env0_template" "Merck-Demo-Subnet" {
  name              = "Merck-Demo-Subnet"
  repository        = "https://github.com/kaugm/env0-demos"
  path              = "blocks/subnet"
  type              = "terraform"
  revision          = "main"
  terraform_version = "RESOLVE_FROM_TERRAFORM_CODE"
  github_installation_id = 61344253
}

resource "env0_template_project_assignment" "merck-subnet-assignment" {
  template_id = env0_template.Merck-Demo-Subnet.id
  project_id  = data.env0_project.karl_project.id
}

output "merck_subnet_template_id" {
  value = env0_template.Merck-Demo-Subnet.name
}



# TEMPLATE 3: EC2
resource "env0_template" "Merck-Demo-EC2" {
  name              = "Merck-Demo-EC2"
  repository        = "https://github.com/kaugm/env0-demos"
  path              = "blocks/ec2"
  type              = "terraform"
  revision          = "main"
  terraform_version = "RESOLVE_FROM_TERRAFORM_CODE"
  github_installation_id = 61344253
}

resource "env0_template_project_assignment" "merck-ec2-assignment" {
  template_id = env0_template.Merck-Demo-EC2.id
  project_id  = data.env0_project.karl_project.id
}

output "merck_ec2_template_id" {
  value = env0_template.Merck-Demo-EC2.name
}


# TEMPLATE 3: ROUTE
resource "env0_template" "Merck-Demo-Route" {
  name              = "Merck-Demo-Route"
  repository        = "https://github.com/kaugm/env0-demos"
  path              = "blocks/route_table"
  type              = "terraform"
  revision          = "main"
  terraform_version = "RESOLVE_FROM_TERRAFORM_CODE"
  github_installation_id = 61344253
}

resource "env0_template_project_assignment" "merck-route-assignment" {
  template_id = env0_template.Merck-Demo-Route.id
  project_id  = data.env0_project.karl_project.id
}

output "merck_route_template_id" {
  value = env0_template.Merck-Demo-Route.name
}


# TEMPLATE 5: VPC PEERING CONNECTION
resource "env0_template" "Merck-Demo-VPC-Peer" {
  name              = "Merck-Demo-VPC-Peering-And-Routes"
  repository        = "https://github.com/kaugm/env0-demos"
  path              = "blocks/vpc_peering"
  type              = "terraform"
  revision          = "main"
  terraform_version = "RESOLVE_FROM_TERRAFORM_CODE"
  github_installation_id = 61344253
}

resource "env0_template_project_assignment" "merck-vpc-peer-assignment" {
  template_id = env0_template.Merck-Demo-VPC-Peer.id
  project_id  = data.env0_project.karl_project.id
}

output "merck_vpc_peer_template_id" {
  value = env0_template.Merck-Demo-VPC-Peer.name
}