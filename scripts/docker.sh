
#!/bin/bash

# Install Docker on an Ubuntu EC2 instance
set -euo pipefail

# Update package lists
sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker.io

# Enable and start Docker
sudo systemctl enable --now docker

# Add Ubuntu user to Docker group
if id ubuntu &>/dev/null; then
    sudo usermod -aG docker ubuntu
fi

# Add Jenkins user to Docker group if Jenkins is installed
if id jenkins &>/dev/null; then
    sudo usermod -aG docker jenkins
fi

# Verify Docker installation
docker --version

# Verify Docker service
sudo systemctl is-active docker

# Test Docker functionality
sudo docker run --rm hello-world

echo "Docker installation completed successfully!"
echo "Log out and log back in for group changes to take effect."

# Optional: Run SonarQube container
# sudo docker run -d --name sonar -p 9000:9000 sonarqube:lts-community