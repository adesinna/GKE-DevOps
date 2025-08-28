resource "google_compute_instance" "vm-1" {
  name         = "vm-1"
  machine_type = "e2-micro"
  zone         = var.zone
  tags         = ["vm-${var.project_id}"]

  network_interface {
    network    = google_compute_network.polom-vpc.id
    subnetwork = google_compute_subnetwork.polom-subnet.id
    access_config {} # assigns a public IP
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
  }
  metadata_startup_script = file("${path.module}/script.sh")
}
