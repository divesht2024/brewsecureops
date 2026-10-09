
#!/bin/bash

# Install Terraform on Ubuntu EC2
set -euo pipefail

# Update package list and install dependencies
sudo apt-get update -y
sudo apt-get install -y gnupg software-properties-common wget ca-certificates lsb-release

# Create keyrings directory
sudo install -d -m 0755 /usr/share/keyrings

# Download and install HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Set key permissions
sudo chmod 644 /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Display key fingerprint for verification
gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint

# Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

# Update package lists
sudo apt-get update -y

# Install Terraform
sudo apt-get install -y terraform

# Verify installation
terraform --version

echo "Terraform installation completed successfully!"