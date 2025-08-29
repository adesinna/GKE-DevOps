resource "google_container_cluster" "gke_cluster" {
  name     = "${local.name}-gke-cluster"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # Network
  network = google_compute_network.myvpc.self_link  # GKE expects self link instead of id
  subnetwork = google_compute_subnetwork.mysubnet.self_link

  deletion_protection = false
}
