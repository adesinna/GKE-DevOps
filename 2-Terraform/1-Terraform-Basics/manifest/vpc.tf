terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.0.1"
    }
  }
}


provider "google" {
  project     = "terraform-470417"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "/home/ubuntu/terraform-sa-key"
}

resource "google_compute_subnetwork" "polom-subnet" {
  name          = "test-subnet"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.polom-vpc.id
}

resource "google_compute_network" "polom-vpc" {
  name                    = "polom-vpc"
  auto_create_subnetworks = false
}