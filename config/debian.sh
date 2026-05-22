#!/bin/bash
# Debian-specific setup for Aether Orchestrator

echo "🐧 Configuring Debian for Aether Orchestrator..."

# Enable backports
echo "deb http://deb.debian.org/debian bookworm-backports main" >> /etc/apt/sources.list

# Install core packages
apt update -y
apt install -y \
    build-essential \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    nodejs \
    npm \
    openssh-client \
    vim \
    tmux \
    htop \
    firefox-esr \
    thunderbird \
    libreoffice \
    gimp \
    inkscape \
    octave \
    r-base

# Install Node.js 20.x from NodeSource
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

echo "✅ Debian configuration complete"
