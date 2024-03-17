#!/bin/bash

set -o errexit

# Download Terraform
wget https://releases.hashicorp.com/terraform/0.18.0/terraform_0.18.0_linux_amd64.zip

# Verify the checksum
echo "feb764eab65a02d7a54a958e966f33dcbcf3476f852b2f130b7a3c46d3b7f3ed  terraform_0.18.0_linux_amd64.zip" | sha256sum -c -

# Unzip the binary
unzip terraform_0.18.0_linux_amd64.zip

# Install the binary
sudo mv terraform /usr/local/bin/

# Clean up
rm terraform_0.18.0_linux_amd64.zip

# Test the installation
terraform --version