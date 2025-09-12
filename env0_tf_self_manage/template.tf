terraform {
  required_version = ">= 1.0.0"
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

# Configure the env0 provider
provider "env0" {
  api_key    = var.ENV0_KEY_ID
  api_secret = var.ENV0_KEY_SECRET
}



### Create and Manage a template with the Env0 Terraform Provider

# Pull Project ID
data "env0_project" "karl_project" {
  name = "Karl"
}

# Step 1: Create Template
resource "env0_template" "karl_azure" {
  name              = "Karl-Demo-Azure-Resources"
  description       = "Example template of Azure resources created with env0 Terraform Provider"
  repository        = "https://github.com/kaugm/env0-demos"
  path              = "azure"
  type              = "terraform"
  revision          = "main"
  terraform_version = "RESOLVE_FROM_TERRAFORM_CODE"
}

# Step 2: Assign Template to Project(s)
resource "env0_template_project_assignment" "assignment" {
  template_id = env0_template.karl_azure.id
  project_id  = data.env0_project.karl_project.id
}


output "template_id" {
  value = env0_template.karl_azure.id
}