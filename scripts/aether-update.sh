#!/bin/bash
# Update script for Aether Orchestrator

echo "🔄 Updating Aether Orchestrator..."

# Stop orchestrator if running
if [ -f "$HOME/aether.pid" ]; then
    echo "🛑 Stopping orchestrator..."
    kill $(cat "$HOME/aether.pid")
    rm "$HOME/aether.pid"
fi

# Update repository
cd "$HOME/aether-grid" || exit
 git pull

# Install dependencies
npm install

# Restart orchestrator
echo "🚀 Restarting orchestrator..."
if [ "$TERMUX_VERSION" ]; then
    cd "$PREFIX/var/lib/aether-grid"
    termux-wake-lock
    nohup node . > "$HOME/aether.log" 2>&1 &
else
    cd "$HOME/aether-grid"
    nohup npm run dev > "$HOME/aether.log" 2>&1 &
fi

echo $! > "$HOME/aether.pid"
echo "✅ Updated and restarted (PID: $(cat "$HOME/aether.pid"))"
