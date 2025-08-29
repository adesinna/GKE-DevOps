# Resource Block: Reserver Internal IP Address for Bastion Host
resource "google_compute_address" "bastion_internal_ip" {  # like elastic ip
  name         = "${local.name}-bastion-internal-ip"
  description  = "Internal IP address reserved for Bastion VM"
  address_type = "INTERNAL"
  region       = var.region
  subnetwork   = google_compute_subnetwork.mysubnet.id
  address      = "10.128.15.15"  # from the subnet range
}

# Resource Block: Create a single Compute Engine instance
resource "google_compute_instance" "bastion" {
  name         = "${local.name}-bastion-vm"
  machine_type = var.machine_type
  zone         = "us-central1-a"
  tags        = ["ssh-tag"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.mysubnet.id
    network_ip = google_compute_address.bastion_internal_ip.address
  }
  metadata_startup_script = file("${path.module}/script.sh")
}

# gcloud compute ssh  "dev-bastion-vm" --zone "us-central1-a" --tunnel-through-iap --project "project_id"



## SSH to GKE Node VM via the jump server
//gcloud compute ssh --zone "ZONE" "VM-NAME" --internal-ip  --project "project_id"
