# Terraform Datasources
data "google_compute_zones" "available" {    # all avaliable compute zones
  status = "UP"
}




resource "google_compute_instance" "myapp1" {
  count = 2  # two resources
  name         = "myapp-${count.index}"
  machine_type = "e2-micro"
  zone         = data.google_compute_zones.available.names[count.index] # use the external data resource
  tags        = [tolist(google_compute_firewall.fw_ssh.target_tags)[0], tolist(google_compute_firewall.fw_http.target_tags)[0]]
  #this converts the resources into list and you can access the tags
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  # Install Webserver
  metadata_startup_script = file("${path.module}/script.sh")
  network_interface {
    subnetwork = google_compute_subnetwork.mysubnet.id 
    access_config {} # give it public ip
  }
}