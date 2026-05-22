#!/bin/bash
# Stop script for Aether Orchestrator

if [ -f "$HOME/aether.pid" ]; then
    kill $(cat "$HOME/aether.pid")
    rm "$HOME/aether.pid"
    echo "✅ Aether Orchestrator stopped"
else
    echo "❌ Aether Orchestrator is not running"
fi

# Also stop bridge if running
if [ -f "$HOME/bridge.pid" ]; then
    kill $(cat "$HOME/bridge.pid")
    rm "$HOME/bridge.pid"
    echo "✅ API Bridge stopped"
fi
