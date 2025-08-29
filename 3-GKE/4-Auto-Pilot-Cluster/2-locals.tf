# Define Local Values in Terraform
locals {
  environment = var.environment
  name = "polom-${var.environment}"
  common_tags = {
    environment = local.environment
  }
}