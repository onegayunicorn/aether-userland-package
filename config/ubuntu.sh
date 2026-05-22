#!/bin/bash
# Ubuntu-specific setup for Aether Orchestrator

echo "🐧 Configuring Ubuntu for Aether Orchestrator..."

# Add PPAs for newer software
add-apt-repository -y ppa:git-core/ppa
add-apt-repository -y ppa:ubuntu-mozilla-security/ppa

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
    firefox \
    thunderbird \
    libreoffice \
    gimp \
    inkscape \
    gnucash \
    octave \
    r-base

# Install Node.js 20.x
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

# Install VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt install -y code

echo "✅ Ubuntu configuration complete"
