#!/bin/bash
# Logs script for Aether Orchestrator

if [ -f "$HOME/aether.log" ]; then
    echo "📜 Aether Orchestrator Logs (Ctrl+C to exit):"
    echo "============================================"
    tail -f "$HOME/aether.log"
else
    echo "❌ No log file found at $HOME/aether.log"
    echo "   Try starting the orchestrator first: aether-start"
fi
