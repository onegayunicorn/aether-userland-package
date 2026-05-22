# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable Bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Aether Orchestrator Aliases
alias aether-start='~/aether-start.sh'
alias aether-stop='[ -f ~/aether.pid ] && kill $(cat ~/aether.pid) && rm ~/aether.pid && echo "✅ Stopped" || echo "❌ Not running"'
alias aether-status='[ -f ~/aether.pid ] && kill -0 $(cat ~/aether.pid) 2>/dev/null && echo "✅ Running (PID: $(cat ~/aether.pid))" || echo "❌ Stopped"'
alias aether-logs='tail -f ~/aether.log'
alias aether-bridge='python3 ~/orchestrator_bridge.py & echo $! > ~/bridge.pid && echo "✅ Bridge started (PID: $(cat ~/bridge.pid))"'
alias aether-update='cd ~/aether-grid && git pull && npm install && echo "✅ Updated"'
alias aether-termux='cd $PREFIX/var/lib/aether-grid && npm run dev'

# Termux-specific aliases
if [ -d "$PREFIX" ]; then
    alias termux-open='termux-open-url'
    alias termux-clip='termux-clipboard-get'
    alias termux-clip-set='termux-clipboard-set'
fi

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Shortcuts
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# History settings
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

# Editor
export EDITOR=vim

# Path adjustments
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# UserLand/Termux environment detection
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
if [ "$ENVIRONMENT" = "termux" ]; then
    echo "📱 Termux + Aether Orchestrator"
elif [ "$ENVIRONMENT" = "userland" ]; then
    echo "🖥️ UserLand + Aether Orchestrator"
else
    echo "🐧 Linux + Aether Orchestrator"
fi

# Set prompt
export PS1='\u@\h:\w\$ '
