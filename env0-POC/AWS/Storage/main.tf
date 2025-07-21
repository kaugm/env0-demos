module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.bucket_name}-${random_string.bucket_suffix.result}"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = var.versioning_enabled
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  upper   = false
  lower   = false
  number  = true
  special = false
}