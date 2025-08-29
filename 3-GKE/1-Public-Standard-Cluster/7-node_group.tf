# Resource: GKE Node Pool 1
resource "google_container_node_pool" "nodepool_1" {
  name       = "${local.name}-node-pool-1"
  location   = var.region
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 1
  node_config {
    preemptible  = true # like spot in aws
    machine_type = var.machine_type
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke_sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"   # what apis the vm can talk to
    ]
    tags = ["ssh-tag"] # so the firewall can use it
  }
}