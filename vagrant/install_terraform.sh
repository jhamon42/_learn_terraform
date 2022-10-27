#!/bin/bash

## Install Terraform

IP=$(hostname -I | awk '{print $2}')

echo "START - install terraform - "$IP


echo "[1]: install utils"
sudo apt-get update -qq >/dev/null
sudo apt-get install -qq -y wget unzip >/dev/null

echo "[1]: install terraform"
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null
sudo apt-get update && sudo apt-get -y install terraform

echo "[2] install docker"
sudo apt-get update && sudo apt-get -y install docker.io

echo "END - terraform installed"