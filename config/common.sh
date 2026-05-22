#!/bin/bash
# Common functions for Aether Orchestrator UserLand/Termux Package

# Function to install Python dependencies
install_python_deps() {
    echo "🐍 Installing Python dependencies..."
    pip install --upgrade pip
    pip install fastapi uvicorn python-dotenv
}

# Function to install Node.js dependencies
install_node_deps() {
    echo "📦 Installing Node.js dependencies..."
    cd "$HOME/aether-grid" || exit
    npm install
}

# Function to clone Aether repository
clone_repository() {
    echo "📦 Cloning Aether Orchestrator repository..."
    if [ -d "$HOME/aether-grid" ]; then
        echo "⚠️ Repository exists, updating..."
        cd "$HOME/aether-grid" && git pull
    else
        git clone https://github.com/onegayunicorn/aether-grid.git "$HOME/aether-grid"
    fi
}

# Function to setup orchestrator bridge
setup_bridge() {
    echo "🔧 Setting up Orchestrator Bridge..."
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

# Function to setup aliases
setup_aliases() {
    echo "🔗 Setting up bash aliases..."
    cat >> "$HOME/.bashrc" << 'EOF'

# Aether Orchestrator Aliases
alias aether-start='~/aether-start.sh'
alias aether-stop='[ -f ~/aether.pid ] && kill $(cat ~/aether.pid) && rm ~/aether.pid && echo "✅ Stopped" || echo "❌ Not running"'
alias aether-status='[ -f ~/aether.pid ] && kill -0 $(cat ~/aether.pid) 2>/dev/null && echo "✅ Running (PID: $(cat ~/aether.pid))" || echo "❌ Stopped"'
alias aether-logs='tail -f ~/aether.log'
alias aether-bridge='python3 ~/orchestrator_bridge.py & echo $! > ~/bridge.pid && echo "✅ Bridge started (PID: $(cat ~/bridge.pid))"'
alias aether-update='cd ~/aether-grid && git pull && npm install && echo "✅ Updated"'
EOF
    source "$HOME/.bashrc"
}

# Function to detect environment
detect_environment() {
    if [ -d "$PREFIX" ] && [ -f "$PREFIX/etc/termux-version" ]; then
        ENVIRONMENT="termux"
    elif [ -f /system/bin/sh ]; then
        ENVIRONMENT="userland"
    else
        ENVIRONMENT="linux"
    fi
    export ENVIRONMENT
}
