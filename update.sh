#!/bin/bash
# Make sure that the /var/tmp/guarde directory is deleted before updating.
sudo rm -rf /var/tmp/guarde

# Make the directory to download updated packages to.
mkdir /var/tmp/guarde

# Download packages from the guarde updates Github repo.
sudo git clone --depth 1 https://github.com/dakotaselectronics/guarde24updates.git /var/tmp/guarde/

# Install any upgrades from the ubuntu repositories before updating GuarDE packages.
sudo apt upgrade -y

# Upgrade GuarDE packages.
DEBIAN_FRONTEND=noninteractive sudo apt install /var/tmp/guarde/*.deb -y --allow-change-held-packages

# Delete temporary download directory.
sudo rm -rf /var/tmp/guarde

# Restart the system.
sudo reboot
