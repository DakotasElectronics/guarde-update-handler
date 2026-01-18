#!/bin/bash
print("GuarDE Update Handler [Version 260120]")
print("2026 Dakota's Electronics Company")

# Make sure that the /var/tmp/guarde directory is deleted before updating.
sudo rm -rf /var/tmp/guarde

# Make the directory to download updated packages to.
mkdir /var/tmp/guarde

# Download packages from the guarde updates Github repo.
manifest="https://dakotaselectronics.github.io/guardeupdates/alaska/release/client"
cd /var/tmp/guarde
wget -q "$manifest/latest"

for pkg in $(jq -r '.packages[]' latest); do
    echo Getting: $pkg
    wget -q "$manifest/$pkg"
done

# Install any upgrades from the ubuntu repositories before updating GuarDE packages.
DEBIAN_FRONTEND=noninteractive sudo apt upgrade -y

# Upgrade GuarDE packages.
DEBIAN_FRONTEND=noninteractive sudo apt install /var/tmp/guarde/*.deb -y --allow-change-held-packages

# Delete temporary download directory.
sudo rm -rf /var/tmp/guarde

# Restart the system.
sudo reboot
