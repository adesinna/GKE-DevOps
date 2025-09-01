# Resource: GKE Linux Node Pool
resource "google_container_node_pool" "linux_nodepool_1" {
  name       = "${local.name}-linux-nodepool-1"
  location   = var.region  #"us-central1-a"  match cluster zone
  cluster    = google_container_cluster.gke_cluster.name
  initial_node_count = 1 # the number of nodes to create in each zone
  node_locations = ["us-central1-a"] # 1 zone
  autoscaling {
    min_node_count = 1
    max_node_count = 3
//    location_policy = "ANY"
  }
  node_config {
    preemptible  = true
    machine_type = var.machine_type
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke_sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    tags = ["ssh-tag"]
    disk_size_gb = 20
    disk_type = "pd-standard" # Supported pd-standard, pd-balanced or pd-ssd, default is pd-standard
  }
}
