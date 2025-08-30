# Terraform Outputs
output "gke_cluster_name" {
  description = "GKE cluster name"
  value = google_container_cluster.gke_cluster.name
}

output "gke_cluster_location" {
  description = "GKE Cluster location"
  value = google_container_cluster.gke_cluster.location
}

output "gke_cluster_endpoint" {
  description = "GKE Cluster Endpoint"
  value = google_container_cluster.gke_cluster.endpoint
}

output "gke_cluster_master_version" {
  description = "GKE Cluster master version"
  value = google_container_cluster.gke_cluster.master_version
}
output "cloudsql_db_private_ip" {
  value = google_sql_database_instance.mydbinstance.private_ip_address
}

output "mydb_schema" {
  value = google_sql_database.mydbschema.name
}

output "mydb_user" {
  value = google_sql_user.users.name
}

output "mydb_password" {
  value = google_sql_user.users.password
  sensitive = true
}
