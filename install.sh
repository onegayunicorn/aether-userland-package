#!/bin/bash
# ============================================================================
# AETHER ORCHESTRATOR - USERLAND/TERMUX PACKAGE INSTALLER
# Supports: Alpine, Arch, Debian, Kali, Ubuntu, Termux
# Target: UserLand/Termux on Android (Moto G35)
# ============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Banner
clear
echo -e "${PURPLE}"
echo "    █████╗ ███████╗████████╗██╗  ██╗███████╗██████╗ "
echo "   ██╔══██╗██╔════╝╚══██╔══╝██║  ██║██╔════╝██╔══██╗"
echo "   ███████║█████╗     ██║   ███████║█████╗  ██████╔╝"
echo "   ██╔══██║██╔══╝     ██║   ██╔══██║██╔══╝  ██╔══██╗"
echo "   ██║  ██║███████╗   ██║   ██║  ██║███████╗██║  ██║"
echo "   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
echo -e "${NC}"
echo -e "${CYAN}   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}          AETHER ORCHESTRATOR - USERLAND/TERMUX INTEGRATION${NC}"
echo -e "${CYAN}   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Detect environment (UserLand vs Termux)
detect_environment() {
    if [ -d "$PREFIX" ] && [ -f "$PREFIX/etc/termux-version" ]; then
        ENVIRONMENT="termux"
        echo -e "${BLUE}📱 Detected environment: ${GREEN}Termux${NC}"
    elif [ -f /system/bin/sh ]; then
        ENVIRONMENT="userland"
        echo -e "${BLUE}📱 Detected environment: ${GREEN}UserLand${NC}"
    else
        ENVIRONMENT="linux"
        echo -e "${BLUE}📱 Detected environment: ${GREEN}Native Linux${NC}"
    fi
}

# Detect distribution
detect_distro() {
    if [ "$ENVIRONMENT" = "termux" ]; then
        DISTRO="termux"
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    elif [ -f /etc/debian_version ]; then
        DISTRO="debian"
    elif [ -f /etc/arch-release ]; then
        DISTRO="arch"
    elif [ -f /etc/alpine-release ]; then
        DISTRO="alpine"
    else
        DISTRO="unknown"
    fi
    echo -e "${BLUE}📡 Detected distribution: ${GREEN}$DISTRO${NC}"
}

# Install dependencies based on distro
install_dependencies() {
    case $DISTRO in
        termux)
            echo -e "${YELLOW}🐧 Installing for Termux...${NC}"
            pkg update -y
            pkg install -y curl wget git python nodejs openssh vim tmux htop neofetch
            pip install --upgrade pip
            pip install fastapi uvicorn python-dotenv
            ;;
        ubuntu|debian|kali)
            echo -e "${YELLOW}🐧 Installing for Debian-based system...${NC}"
            apt update -y
            apt install -y curl wget git python3 python3-pip nodejs npm \
                build-essential openssh-client vim tmux htop
            pip3 install --upgrade pip
            pip3 install fastapi uvicorn python-dotenv
            ;;
        arch)
            echo -e "${YELLOW}🐧 Installing for Arch-based system...${NC}"
            pacman -Sy --noconfirm curl wget git python python-pip nodejs npm \
                base-devel openssh vim tmux htop
            pip install --upgrade pip
            pip install fastapi uvicorn python-dotenv
            ;;
        alpine)
            echo -e "${YELLOW}🐧 Installing for Alpine-based system...${NC}"
            apk update
            apk add curl wget git python3 py3-pip nodejs npm \
                build-base openssh-client vim tmux htop
            pip3 install --upgrade pip
            pip3 install fastapi uvicorn python-dotenv
            ;;
        *)
            echo -e "${RED}❌ Unsupported distribution: $DISTRO${NC}"
            exit 1
            ;;
    esac
}

# Clone Aether repository
clone_repository() {
    echo -e "${BLUE}📦 Cloning Aether Orchestrator repository...${NC}"
    if [ -d "$HOME/aether-grid" ]; then
        echo -e "${YELLOW}⚠️ Repository exists, updating...${NC}"
        cd "$HOME/aether-grid" && git pull
    else
        git clone https://github.com/onegayunicorn/aether-grid.git "$HOME/aether-grid"
    fi
}

# Install Node.js dependencies
install_node_deps() {
    echo -e "${BLUE}📦 Installing Node.js dependencies...${NC}"
    cd "$HOME/aether-grid"
    npm install
}

# Setup orchestrator bridge
setup_bridge() {
    echo -e "${BLUE}🔧 Setting up Orchestrator Bridge...${NC}"
    cat > "$HOME/orchestrator_bridge.py" << 'EOF'
#!/usr/bin/env python3
import os
import subprocess
import json
from fastapi import FastAPI, HTTPException
from dotenv import load_dotenv
import uvicorn

load_dotenv()
SOVEREIGN_KEY = os.getenv("SOVEREIGN_KEY", os.urandom(16).hex())
app = FastAPI(title="Aether Orchestrator Bridge")

@app.get("/health")
async def health():
    return {"status": "healthy", "coherence": 0.99997, "environment": os.getenv("ENVIRONMENT", "userland")}

@app.post("/api/command")
async def command(request: dict):
    if request.get("auth_key") != SOVEREIGN_KEY:
        raise HTTPException(status_code=403, detail="Invalid sovereign key")
    cmd = request.get("command", "")
    # Security: Allow only whitelisted commands
    ALLOWED_COMMANDS = ["status", "health", "logs", "update", "start", "stop"]
    if not any(cmd.startswith(allowed) for allowed in ALLOWED_COMMANDS):
        raise HTTPException(status_code=400, detail="Command not allowed")
    result = subprocess.run(
        f"cd $HOME/aether-grid && {cmd}",
        shell=True,
        capture_output=True,
        text=True
    )
    return {"output": result.stdout, "error": result.stderr}

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8080)
EOF
    chmod +x "$HOME/orchestrator_bridge.py"
}

# Setup Termux-specific configurations
setup_termux() {
    if [ "$DISTRO" = "termux" ]; then
        echo -e "${BLUE}🔧 Setting up Termux-specific configurations...${NC}"
        # Set up Termux storage
        termux-setup-storage
        # Install Termux:API for device access
        pkg install -y termux-api
        # Configure Termux environment
        echo "export PREFIX=$PREFIX" >> "$HOME/.bashrc"
        echo "export PATH=\$PREFIX/bin:\$PATH" >> "$HOME/.bashrc"
        # Create symlink for aether-grid in Termux home
        ln -sf "$HOME/aether-grid" "$PREFIX/var/lib/aether-grid"
    fi
}

# Create start script (updated for Termux)
create_start_script() {
    echo -e "${BLUE}🚀 Creating start script...${NC}"
    cat > "$HOME/aether-start.sh" << 'EOF'
#!/bin/bash
if [ "$TERMUX_VERSION" ]; then
    # Termux: Use proot for better compatibility
    echo "🌌 Starting Aether Orchestrator in Termux (proot)..."
    cd "$PREFIX/var/lib/aether-grid"
    termux-wake-lock
    nohup node . > "$HOME/aether.log" 2>&1 &
else
    # UserLand/Native Linux
    echo "🌌 Starting Aether Orchestrator..."
    cd "$HOME/aether-grid"
    nohup npm run dev > "$HOME/aether.log" 2>&1 &
fi
echo $! > "$HOME/aether.pid"
echo "✅ Started (PID: $(cat "$HOME/aether.pid"))"
if [ "$TERMUX_VERSION" ]; then
    echo "📍 http://localhost:8080 (Termux)"
    termux-open-url http://localhost:8080
else
    echo "📍 http://localhost:3000 (UserLand)"
fi
EOF
    chmod +x "$HOME/aether-start.sh"
}

# Create bash aliases (updated for Termux)
setup_aliases() {
    echo -e "${BLUE}🔗 Setting up bash aliases...${NC}"
    cat >> "$HOME/.bashrc" << 'EOF'

# Aether Orchestrator Aliases
alias aether-start='~/aether-start.sh'
alias aether-stop='[ -f ~/aether.pid ] && kill $(cat ~/aether.pid) && rm ~/aether.pid && echo "✅ Stopped" || echo "❌ Not running"'
alias aether-status='[ -f ~/aether.pid ] && kill -0 $(cat ~/aether.pid) 2>/dev/null && echo "✅ Running (PID: $(cat ~/aether.pid))" || echo "❌ Stopped"'
alias aether-logs='tail -f ~/aether.log'
alias aether-bridge='python3 ~/orchestrator_bridge.py & echo $! > ~/bridge.pid && echo "✅ Bridge started (PID: $(cat ~/bridge.pid))"'
alias aether-update='cd ~/aether-grid && git pull && npm install && echo "✅ Updated"'
alias aether-termux='cd $PREFIX/var/lib/aether-grid && npm run dev'
EOF
    source "$HOME/.bashrc"
}

# Install GUI tools (UserLand only)
install_gui_tools() {
    if [ "$ENVIRONMENT" = "userland" ]; then
        echo -e "${BLUE}🌐 Installing GUI tools (UserLand)...${NC}"
        case $DISTRO in
            ubuntu|debian|kali)
                apt install -y firefox thunderbird libreoffice gimp inkscape gnucash octave r-base
                ;;
            arch)
                pacman -S --noconfirm firefox thunderbird libreoffice-fresh gimp inkscape gnucash octave r
                ;;
            alpine)
                apk add firefox thunderbird libreoffice gimp inkscape gnucash octave r
                ;;
        esac
    else
        echo -e "${YELLOW}⚠️ Skipping GUI tools (Termux/Native Linux). Use Termux:X11 or VNC for GUI apps.${NC}"
    fi
}

# Install development tools
install_dev_tools() {
    echo -e "${BLUE}💻 Installing development tools...${NC}"
    case $DISTRO in
        termux)
            pkg install -y vscode git git-extras
            ;;
        ubuntu|debian|kali)
            apt install -y code git gitk idle3
            ;;
        arch)
            pacman -S --noconfirm code git gitg idle
            ;;
        alpine)
            apk add code git idle
            ;;
    esac

    # Git configuration
    git config --global user.name "Sovereign Architect"
    git config --global user.email "tyrone@onegayunicorn.foundation"
    git config --global core.editor "vim"
    git config --global init.defaultBranch "main"
}

# Setup Termux proot environment (for full Linux compatibility)
setup_proot() {
    if [ "$DISTRO" = "termux" ]; then
        echo -e "${BLUE}🔧 Setting up proot for full Linux environment...${NC}"
        if ! command -v proot &> /dev/null; then
            pkg install -y proot
        fi
        # Install Ubuntu in proot
        if [ ! -d "$PREFIX/var/pxp/ubuntu-fs" ]; then
            echo -e "${YELLOW}📦 Installing Ubuntu in proot (this may take a while)...${NC}"
            pkg install -y proot-distro
            proot-distro install ubuntu
            proot-distro login ubuntu -- bash -c "apt update && apt install -y curl wget git python3 nodejs npm"
        fi
    fi
}

# Main execution
main() {
    detect_environment
    detect_distro
    install_dependencies
    clone_repository
    install_node_deps
    setup_bridge
    setup_termux
    create_start_script
    setup_aliases
    setup_proot
    install_gui_tools
    install_dev_tools
    
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   ✅ AETHER ORCHESTRATOR INSTALLED SUCCESSFULLY              ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}🚀 Quick Start:${NC}"
    if [ "$DISTRO" = "termux" ]; then
        echo -e "   ${CYAN}aether-start${NC}      - Start in Termux (port 8080)"
        echo -e "   ${CYAN}aether-termux${NC}    - Start in proot Ubuntu"
        echo -e "   ${CYAN}termux-open-url http://localhost:8080${NC} - Open in browser"
    else
        echo -e "   ${CYAN}aether-start${NC}      - Start the orchestrator"
        echo -e "   ${CYAN}aether-status${NC}     - Check status"
        echo -e "   ${CYAN}aether-stop${NC}       - Stop orchestrator"
        echo -e "   ${CYAN}aether-logs${NC}       - View logs"
        echo -e "   ${CYAN}aether-bridge${NC}     - Start API bridge"
    fi
    echo ""
    echo -e "${YELLOW}📍 Access:${NC}"
    if [ "$DISTRO" = "termux" ]; then
        echo -e "   ${GREEN}Termux: http://localhost:8080${NC}"
        echo -e "   ${GREEN}Proot:   http://localhost:3000 (via aether-termux)${NC}"
    else
        echo -e "   ${GREEN}Portal:  http://localhost:3000${NC}"
        echo -e "   ${GREEN}Bridge:  http://localhost:8080${NC}"
    fi
    echo ""
    echo -e "${YELLOW}💡 Termux Tips:${NC}"
    echo -e "   - Use ${CYAN}termux-wake-lock${NC} to prevent sleep"
    echo -e "   - Install ${CYAN}Termux:X11${NC} for GUI apps"
    echo -e "   - Run ${CYAN}proot-distro login ubuntu${NC} for full Linux"
    echo ""
}

main
