#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Updating package lists..."
sudo apt-get update

echo "Installing required dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates gnupg curl wget lsb-release software-properties-common

# -------------------------
# Install Google Cloud CLI
# -------------------------
echo "Setting up Google Cloud SDK repository..."
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

echo "Updating package lists for Google Cloud SDK..."
sudo apt-get update
echo "Installing Google Cloud CLI..."
sudo apt-get install -y google-cloud-cli
sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin

echo "Initializing Google Cloud CLI..."
gcloud init

gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com


# -------------------------
# Install Terraform
# -------------------------
echo "Setting up HashiCorp repository for Terraform..."
wget -qO- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

UBUNTU_CODENAME=$(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "Updating package lists for HashiCorp..."
sudo apt-get update
echo "Installing Terraform..."
sudo apt-get install -y terraform

echo "Installation complete!"
terraform -version
gcloud --version
