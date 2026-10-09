
#!/bin/bash

# Jenkins installation on Ubuntu EC2
set -euo pipefail

echo "Updating package lists..."
sudo apt-get update -y

# Install Java 21 and required packages
sudo apt-get install -y fontconfig openjdk-21-jre curl

# Verify Java installation
java -version

# Create keyrings directory
sudo install -d -m 0755 /etc/apt/keyrings

# Download the official Jenkins LTS signing key
sudo curl -fsSL \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key \
  -o /etc/apt/keyrings/jenkins-keyring.asc

# Add Jenkins LTS repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists and install Jenkins
sudo apt-get update -y
sudo apt-get install -y jenkins

# Enable Jenkins at boot and start the service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Verify service status
if sudo systemctl is-active --quiet jenkins; then
    echo "Jenkins is running successfully!"
else
    echo "Jenkins failed to start. Check the logs:"
    sudo journalctl -u jenkins -n 50 --no-pager
    exit 1
fi

# Display Jenkins version
jenkins --version

echo "Jenkins installation completed!"
echo "Access Jenkins at http://<EC2-PUBLIC-IP>:8080"
echo "Initial admin password:"
echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"