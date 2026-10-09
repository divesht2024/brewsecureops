
#!/bin/bash

# Exit if any command fails
set -e

# Update package list
sudo apt-get update -y

# Install required packages
sudo apt-get install -y curl unzip

# Download AWS CLI v2 installer
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Extract installer
unzip -q awscliv2.zip

# Install AWS CLI
sudo ./aws/install

# Verify installation
aws --version

# Cleanup installer files
rm -rf aws awscliv2.zip

echo "AWS CLI installation completed successfully!"