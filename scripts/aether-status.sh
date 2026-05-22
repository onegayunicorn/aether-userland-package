#!/bin/bash
# Status script for Aether Orchestrator

if [ -f "$HOME/aether.pid" ]; then
    if kill -0 $(cat "$HOME/aether.pid") 2>/dev/null; then
        echo "✅ Aether Orchestrator is running (PID: $(cat "$HOME/aether.pid"))"
        if [ "$TERMUX_VERSION" ]; then
            echo "📍 Access at: http://localhost:8080"
        else
            echo "📍 Access at: http://localhost:3000"
        fi
    else
        echo "⚠️ Aether Orchestrator PID file exists but process is not running"
        echo "   Try: aether-stop && aether-start"
    fi
else
    echo "❌ Aether Orchestrator is not running"
fi

# Check bridge status
if [ -f "$HOME/bridge.pid" ]; then
    if kill -0 $(cat "$HOME/bridge.pid") 2>/dev/null; then
        echo "✅ API Bridge is running (PID: $(cat "$HOME/bridge.pid"))"
        echo "📍 Access at: http://localhost:8080"
    else
        echo "⚠️ API Bridge PID file exists but process is not running"
    fi
else
    echo "❌ API Bridge is not running"
fi
