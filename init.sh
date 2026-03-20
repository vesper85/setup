#!/bin/bash

set -e

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing basic tools..."
sudo apt install -y \
  curl \
  wget \
  git \
  build-essential \
  unzip \
  software-properties-common

# -----------------------------
# Install Node.js (LTS)
# -----------------------------
echo "🟢 Installing Node.js (LTS)..."

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Verify
node -v
npm -v

# -----------------------------
# Install pnpm (optional but useful)
# -----------------------------
echo "📦 Installing pnpm..."
npm install -g pnpm

# -----------------------------
# Install Python (optional)
# -----------------------------
echo "🐍 Installing Python..."
sudo apt install -y python3 python3-pip

# -----------------------------
# Install Docker (optional)
# -----------------------------
echo "🐳 Installing Docker..."

sudo apt install -y ca-certificates gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group
sudo usermod -aG docker $USER

echo "✅ Setup complete!"
echo "⚠️ Log out and back in to use Docker without sudo"
