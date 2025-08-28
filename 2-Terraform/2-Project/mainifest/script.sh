#!/bin/bash

# Get the external (public) IP
PUBLIC_IP=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip" -H "Metadata-Flavor: Google")

# Get the internal IP (subnet IP)
INTERNAL_IP=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip" -H "Metadata-Flavor: Google")

# Get the subnet name
SUBNET_NAME=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/subnetwork" -H "Metadata-Flavor: Google" | awk -F'/' '{print $NF}')

echo "Public IP: $PUBLIC_IP"
echo "Internal IP: $INTERNAL_IP"
echo "Subnet: $SUBNET_NAME"
