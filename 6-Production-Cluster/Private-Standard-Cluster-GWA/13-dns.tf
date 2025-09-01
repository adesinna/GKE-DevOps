# Resource: Cloud DNS Record Set for A Record
resource "google_dns_record_set" "A_record" {

  managed_zone = var.dns_managed_zone
  name         = var.my_domain
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_address.static_ip.address]
}