#!/bin/bash
# Development tools setup for Aether Orchestrator

echo "💻 Configuring development environment..."

# Git configuration
git config --global user.name "Sovereign Architect"
git config --global user.email "tyrone@onegayunicorn.foundation"
git config --global core.editor "vim"
git config --global init.defaultBranch "main"

# Generate SSH key if not exists
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-keygen -t ed25519 -C "tyrone@onegayunicorn.foundation" -f "$HOME/.ssh/id_ed25519" -N ""
    echo "SSH key generated: $(cat $HOME/.ssh/id_ed25519.pub)"
fi

# Install VSCode extensions (if VSCode is available)
if command -v code &> /dev/null; then
    code --install-extension ms-python.python
    code --install-extension ms-vscode.vscode-typescript-next
    code --install-extension rust-lang.rust-analyzer
    code --install-extension eamodio.gitlens
    code --install-extension ms-azuretools.vscode-docker
fi

# Create projects directory
mkdir -p "$HOME/Projects"
cd "$HOME/Projects" || exit

# Clone Aether Grid if not exists
if [ ! -d "aether-grid" ]; then
    git clone https://github.com/onegayunicorn/aether-grid.git
fi

echo "✅ Development environment configured"
echo "💡 Run 'code $HOME/Projects/aether-grid' to open in VSCode"
