
#!/bin/bash

# Install Trivy on Ubuntu EC2
set -euo pipefail

# Update package lists
sudo apt-get update -y

# Install required dependencies
sudo apt-get install -y wget curl gnupg lsb-release ca-certificates

# Create keyrings directory
sudo install -d -m 0755 /usr/share/keyrings

# Download and install Trivy repository signing key
curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key \
  | sudo gpg --dearmor --yes -o /usr/share/keyrings/trivy.gpg

# Add Trivy repository
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
  | sudo tee /etc/apt/sources.list.d/trivy.list > /dev/null

# Update package lists
sudo apt-get update -y

# Install Trivy
sudo apt-get install -y trivy

# Verify installation
trivy --version

echo "Trivy installation completed successfully!"