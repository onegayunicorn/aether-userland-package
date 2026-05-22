#!/bin/bash
# Kali-specific setup for Aether Orchestrator

echo "🐧 Configuring Kali for Aether Orchestrator..."

# Update repositories
apt update -y
apt full-upgrade -y

# Install core packages
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
    r-base \
    kali-linux-headless

# Install VSCode
apt install -y code-oss

echo "✅ Kali configuration complete"
