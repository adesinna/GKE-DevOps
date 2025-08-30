# Resource: Private Service Connection   //this is the peering to our vpc
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.myvpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip.name]
  deletion_policy = "ABANDON" # After terraform destroy, destroy it manually
}