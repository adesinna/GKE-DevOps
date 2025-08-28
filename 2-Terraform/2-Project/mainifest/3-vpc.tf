resource "google_compute_network" "polom-vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}