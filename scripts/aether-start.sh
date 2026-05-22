#!/bin/bash
# Start script for Aether Orchestrator
# Works in both UserLand and Termux

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
