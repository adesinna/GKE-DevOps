# Resource: VPC
resource "google_compute_network" "myvpc" {
  name = "vpc1"
  auto_create_subnetworks = false
  provider =  "project-1"
}

resource "google_compute_network" "myvpc" {
  name = "vpc1"
  auto_create_subnetworks = false
  provider =  "project-2"
}

