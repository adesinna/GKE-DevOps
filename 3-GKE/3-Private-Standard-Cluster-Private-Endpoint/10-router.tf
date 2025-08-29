# Resource: Cloud Router
resource "google_compute_router" "cloud_router" {
  name    = "${local.name}-${var.region}-cloud-router"
  network = google_compute_network.myvpc.id
  region  = var.region
}

