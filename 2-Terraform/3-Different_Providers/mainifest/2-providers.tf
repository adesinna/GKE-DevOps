provider "google" {
  project     = var.project_id-1
  region      = var.region
  zone        = var.zone
  credentials = "/home/ubuntu/terraform-sa-key.json"
  alias = "project-1"
}

provider "google" {
  project     = var.project_id-2
  region      = var.region
  zone        = var.zone
  credentials = "/home/ubuntu/terraform-sa-key.json"
  alias = "project-2"
}