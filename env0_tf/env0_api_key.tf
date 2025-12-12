terraform {
  required_version = ">= 1.0.0"
  required_providers {
    env0 = {
      source = "env0/env0"
      version = "1.29.7"
    }
  }
}

variable "key_id" {}
variable "key_secret" {}

# Configure the env0 provider
provider "env0" {
  api_key    = var.key_id
  api_secret = var.key_secret
}


# Pull Project ID
data "env0_project" "this" {
  name = "Karl"
}

# TESTING: Create API Key
resource "env0_api_key" "testing" {

  name              = "Karl-testing-shared-token" # Required
  organization_role = "User" # Optional. API Key type: 'User' or 'Admin', defaults to 'Admin'. 'User' keys can be assigned regular permissions

  # Only valid for organization_role = "User"
  project_permissions {
    project_id   = data.env0_project.this.id # Which project to assign permissions to
    project_role = "Admin" # Project level permissions: Planner, Viewer, Deployer, Admin
  }
}


output "project_id" {
  value = data.env0_project.this.id
}

output "key_id" {
  value = env0_api_key.testing.id
}
