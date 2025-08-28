resource "google_compute_subnetwork" "mysubnet" {
  name = "subnet1"
  region = "us-central1"
  ip_cidr_range = "10.128.0.0/20"
  network = google_compute_network.myvpc.id
}
