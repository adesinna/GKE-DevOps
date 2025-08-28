provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = "/home/ubuntu/terraform-sa-key.json"
}