#!/bin/bash
# Arch-specific setup for Aether Orchestrator

echo "🐧 Configuring Arch for Aether Orchestrator..."

# Update system
pacman -Syu --noconfirm

# Install core packages
pacman -S --noconfirm \
    base-devel \
    curl \
    wget \
    git \
    python \
    python-pip \
    nodejs \
    npm \
    openssh \
    vim \
    tmux \
    htop \
    firefox \
    thunderbird \
    libreoffice-fresh \
    gimp \
    inkscape \
    octave \
    r \
    gnucash \
    code

echo "✅ Arch configuration complete"
