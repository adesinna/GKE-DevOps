# Input Variables
# GCP Project
variable "project_id" {
  description = "Project in which GCP Resources to be created"
  type = string
  default = "terraform-470417"
}

# GCP Region
variable "region" {
  description = "Region in which GCP Resources to be created"
  type = string
  default = "us-east1"
}

# GCP Compute Engine Machine Type
variable "machine_type" {
  description = "Compute Engine Machine Type"
  type = string
  default = "e2-small"
}


# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
