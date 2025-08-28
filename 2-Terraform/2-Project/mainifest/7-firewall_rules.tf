resource "google_compute_firewall" "default" {
  name    = "vm-firewall"
  network = google_compute_network.polom-vpc.id
  direction = "INGRESS"


  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_tags = ["vm-${var.project_id}"]
}

