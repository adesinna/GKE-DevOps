resource "google_container_cluster" "gke_cluster" {
  name     = "${local.name}-gke-cluster"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  # Add this block to reduce SSD usage for the temporary node pool
  node_config {
    disk_size_gb = 20    # Minimum size instead of default 100GB
    disk_type    = "pd-standard"  # Use standard disk instead of SSD
    machine_type = "e2-micro"  # Use smallest machine type
  }

  network    = google_compute_network.myvpc.self_link
  subnetwork = google_compute_subnetwork.mysubnet.self_link
  deletion_protection = false
}