# Apex domain authorization
resource "google_certificate_manager_dns_authorization" "apex" {
  location    = var.region
  name        = "${local.name}-apex-dns-authorization"
  description = "DNS authorization for shanana.shop"
  domain      = "shanana.shop"
}

# Wildcard domain authorization
resource "google_certificate_manager_dns_authorization" "wildcard" {
  location    = var.region
  name        = "${local.name}-wildcard-dns-authorization"
  description = "DNS authorization for *.shanana.shop"
  domain      = "*.shanana.shop"
}


# Apex domain DNS record
resource "google_dns_record_set" "apex" {
  managed_zone = var.dns_managed_zone
  name         = google_certificate_manager_dns_authorization.apex.dns_resource_record[0].name
  type         = google_certificate_manager_dns_authorization.apex.dns_resource_record[0].type
  ttl          = 300
  rrdatas      = [google_certificate_manager_dns_authorization.apex.dns_resource_record[0].data]
}

# Wildcard domain DNS record
resource "google_dns_record_set" "wildcard" {
  managed_zone = var.dns_managed_zone
  name         = google_certificate_manager_dns_authorization.wildcard.dns_resource_record[0].name
  type         = google_certificate_manager_dns_authorization.wildcard.dns_resource_record[0].type
  ttl          = 300
  rrdatas      = [google_certificate_manager_dns_authorization.wildcard.dns_resource_record[0].data]
}


resource "google_certificate_manager_certificate" "myapp" {
  location    = var.region
  name        = "${local.name}-ssl-certificate"
  description = "Certificate for shanana.shop and *.shanana.shop"
  scope       = "DEFAULT"

  managed {
    domains = [
      google_certificate_manager_dns_authorization.apex.domain,
      google_certificate_manager_dns_authorization.wildcard.domain
    ]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.apex.id,
      google_certificate_manager_dns_authorization.wildcard.id
    ]
  }
}
