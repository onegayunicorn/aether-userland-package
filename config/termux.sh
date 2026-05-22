#!/bin/bash
# Termux-specific setup for Aether Orchestrator
# Uses proot for full Linux environment compatibility

echo "🐧 Configuring Termux for Aether Orchestrator..."

# Update and upgrade
pkg update -y
pkg upgrade -y

# Install core packages
pkg install -y \
    curl \
    wget \
    git \
    python \
    nodejs \
    npm \
    openssh \
    vim \
    tmux \
    htop \
    neofetch \
    termux-api \
    proot \
    proot-distro

# Install proot-distro for Ubuntu
echo "📦 Installing Ubuntu in proot..."
proot-distro install ubuntu

# Set up Ubuntu environment
proot-distro login ubuntu -- bash -c "
    apt update && apt upgrade -y
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
        libreoffice \
        gimp \
        inkscape \
        octave \
        r-base
    pip3 install --upgrade pip
    pip3 install fastapi uvicorn python-dotenv
"

# Configure Termux environment
echo "export PREFIX=\$PREFIX" >> "$HOME/.bashrc"
echo "export PATH=\$PREFIX/bin:\$PATH" >> "$HOME/.bashrc"
echo "alias aether-termux='proot-distro login ubuntu -- cd /root/aether-grid && npm run dev'" >> "$HOME/.bashrc"

# Clone Aether Orchestrator in proot Ubuntu
proot-distro login ubuntu -- bash -c "git clone https://github.com/onegayunicorn/aether-grid.git /root/aether-grid"

# Install Node.js dependencies in proot
proot-distro login ubuntu -- bash -c "cd /root/aether-grid && npm install"

# Set up Termux storage
termux-setup-storage

# Create symlink for easy access
ln -sf "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/root/aether-grid" "$HOME/aether-grid-termux"

echo "✅ Termux configuration complete"
echo "💡 Run 'aether-start' to launch in Termux"
echo "💡 Run 'aether-termux' to launch in proot Ubuntu"
