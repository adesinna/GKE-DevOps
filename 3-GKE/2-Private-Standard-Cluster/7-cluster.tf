# Resource: GKE Cluster
resource "google_container_cluster" "gke_cluster" {
  name     = "${local.name}-gke-cluster"
  location = var.region

  # Node Locations: Get from Datasource: google_compute_zones
//  node_locations = data.google_compute_zones.available.names

  # Create the smallest possible default node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

   node_config {
    disk_size_gb = 20    # Minimum size instead of default 100GB
    disk_type    = "pd-standard"  # Use standard disk instead of SSD
    machine_type = var.machine_type
  }

  # Network
  network = google_compute_network.myvpc.self_link
  subnetwork = google_compute_subnetwork.mysubnet.self_link

  # In production, change it to true (Enable it to avoid accidental deletion)
  deletion_protection = false

  # Private Cluster Configurations
  private_cluster_config {
    enable_private_endpoint = false # it means you do not need a bastion host to communicate to your cluster
    enable_private_nodes    = true  # it means it will have only private ips only
    master_ipv4_cidr_block  = var.master_ip_range
  }

  # IP Address Ranges
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.pods_ip_range  # ip for pods in the control plan
    services_ipv4_cidr_block = var.services_ip_range   # ip for services in the control plane
  }

  # Allow access to Kubernetes master API Endpoint
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "0.0.0.0/0"
      display_name = "entire-internet"
    }
  }
}



/*
Important Note-1: It is recommended that node pools be created and
managed as separate resources as in the example above.
This allows node pools to be added and removed without recreating the cluster.
Node pools defined directly in the google_container_cluster resource cannot be
removed without re-creating the cluster.

Important Note-2:
We can't create a cluster with no node pool defined, but we want to only use
separately managed node pools. So we create the smallest possible default
node pool and immediately delete it.

Important Note-3:
Google recommends custom service accounts that have cloud-platform scope and
permissions granted via IAM Roles.
*/
