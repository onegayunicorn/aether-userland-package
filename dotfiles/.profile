# ~/.profile: executed by the command interpreter for login shells.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Termux-specific PATH
export PATH="$PREFIX/bin:$PATH"

# Environment variables
export EDITOR=vim
export PAGER=less

# Aether Orchestrator environment
export AETHER_HOME="$HOME/aether-grid"
export SOVEREIGN_KEY="${SOVEREIGN_KEY:-$(python3 -c "import secrets; print(secrets.token_hex(32))")}"

# UserLand/Termux detection
detect_environment() {
    if [ -d "$PREFIX" ] && [ -f "$PREFIX/etc/termux-version" ]; then
        export ENVIRONMENT="termux"
    elif [ -f /system/bin/sh ]; then
        export ENVIRONMENT="userland"
    else
        export ENVIRONMENT="linux"
    fi
}

detect_environment

# Welcome message
echo ""
echo "🌌 Aether Orchestrator - UserLand/Termux Integration"
echo "=================================================="
echo "Environment: $ENVIRONMENT"
echo "Aether Home: $AETHER_HOME"
echo ""
echo "Commands:"
echo "  aether-start  - Start orchestrator"
echo "  aether-stop   - Stop orchestrator"
echo "  aether-status - Check status"
echo "  aether-logs   - View logs"
echo "  aether-bridge - Start API bridge"
echo "  aether-update - Update package"
echo ""
