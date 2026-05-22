#!/bin/bash
# Alpine-specific setup for Aether Orchestrator

echo "🐧 Configuring Alpine for Aether Orchestrator..."

# Update repositories
apk update
apk upgrade

# Install core packages
apk add \
    build-base \
    curl \
    wget \
    git \
    python3 \
    py3-pip \
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
    octave \
    r \
    gnucash \
    vscode

# Install Node.js 20.x from community
apk add nodejs-current npm-current

echo "✅ Alpine configuration complete"
