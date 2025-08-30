# Resource: Reserve Private IP range for VPC Peering
resource "google_compute_global_address" "private_ip" {
  name          = "${local.name}-vpc-peer-privateip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.myvpc.id
}


