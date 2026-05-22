#!/bin/bash
# Game setup for Aether Orchestrator (Zork/Adventure)

echo "🎮 Configuring games..."

# Create games directory
mkdir -p "$HOME/games"
cd "$HOME/games" || exit

# Download Zork if not exists
if [ ! -f "zork1.z5" ]; then
    echo "📥 Downloading Zork..."
    curl -o zork1.z5 https://ifarchive.org/if-archive/infocom/games/zcode/zork1.z5
fi

# Install Frotz (Zork interpreter) if not available
if ! command -v frotz &> /dev/null; then
    case $(uname -s) in
        Linux*)
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                if [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ]; then
                    sudo apt install -y frotz
                elif [ "$ID" = "arch" ]; then
                    sudo pacman -S --noconfirm frotz
                fi
            fi
            ;;
    esac
fi

# Create Zork launcher
cat > "$HOME/bin/zork" << 'EOF'
#!/bin/bash
if command -v frotz &> /dev/null; then
    frotz "$HOME/games/zork1.z5"
else
    echo "Frotz interpreter not found. Install it first:"
    echo "  Ubuntu/Debian: sudo apt install frotz"
    echo "  Arch: sudo pacman -S frotz"
fi
EOF
chmod +x "$HOME/bin/zork"

# Create adventure game
cat > "$HOME/bin/adventure" << 'EOF'
#!/bin/bash
python3 -c "
import random
import time

print('🏰 AETHER ORCHESTRATOR ADVENTURE')
print('=' * 40)
print('You stand before the Quantum Nexus...')
print()

rooms = [
    'The Quantum Nexus',
    'The Orchestrator Core',
    'The Fold Chamber',
    'The Entanglement Hall',
    'The Alchemical Forge',
    'The Dawn of Time'
]

current_room = random.choice(rooms)
print(f'You are in: {current_room}')
print()

# Simple game loop
while True:
    print('What do you do? (look/quit)')
    action = input('> ').lower().strip()
    
    if action == 'quit':
        print('Farewell, Sovereign Architect!')
        break
    elif action == 'look':
        print()
        print(f'You see the {current_room} shimmering with quantum energy.')
        print(f'Coherence: {random.uniform(0.9999, 1.0):.5f}')
        print(f'Entanglement: {random.randint(200, 300)} pairs')
        print()
        # Move to a new room
        current_room = random.choice(rooms)
        print(f'You move to: {current_room}')
        print()
    else:
        print('Unknown command. Try "look" or "quit".')
        print()
"
EOF
chmod +x "$HOME/bin/adventure"

# Create a simple text-based game for Termux
cat > "$HOME/bin/aether-quest" << 'EOF'
#!/bin/bash
# Aether Quest - Simple text adventure for Termux

echo "🌌 AETHER QUEST"
echo "=============="
echo "Find the Fold Entry to win!"
echo

# Game state
HP=100
COHERENCE=0.99997
ROOM=1

# Game loop
while [ $HP -gt 0 ]; do
    case $ROOM in
        1)
            echo "You are in the Quantum Nexus."
            echo "Exits: north (to Orchestrator Core), east (to Fold Chamber)"
            echo -n "> "
            read ACTION
            if [ "$ACTION" = "north" ]; then
                ROOM=2
            elif [ "$ACTION" = "east" ]; then
                ROOM=3
            else
                echo "Invalid direction!"
            fi
            ;;
        2)
            echo "You are in the Orchestrator Core."
            echo "The machines hum with energy. Coherence: $COHERENCE"
            echo "Exits: south (to Quantum Nexus), west (to Alchemical Forge)"
            echo -n "> "
            read ACTION
            if [ "$ACTION" = "south" ]; then
                ROOM=1
            elif [ "$ACTION" = "west" ]; then
                ROOM=4
            else
                echo "Invalid direction!"
            fi
            ;;
        3)
            echo "You are in the Fold Chamber."
            echo "The air shimmers with possibility."
            echo "Exits: west (to Quantum Nexus), down (to Entanglement Hall)"
            echo -n "> "
            read ACTION
            if [ "$ACTION" = "west" ]; then
                ROOM=1
            elif [ "$ACTION" = "down" ]; then
                ROOM=5
            else
                echo "Invalid direction!"
            fi
            ;;
        4)
            echo "You are in the Alchemical Forge."
            echo "The fires of transmutation burn bright."
            echo "Exits: east (to Orchestrator Core)"
            echo -n "> "
            read ACTION
            if [ "$ACTION" = "east" ]; then
                ROOM=2
            else
                echo "Invalid direction!"
            fi
            ;;
        5)
            echo "You are in the Entanglement Hall."
            echo "288 pairs of entangled particles dance around you."
            echo "Exits: up (to Fold Chamber)"
            echo -n "> "
            read ACTION
            if [ "$ACTION" = "up" ]; then
                ROOM=3
            else
                echo "Invalid direction!"
            fi
            ;;
    esac
    
    # Random event
    if [ $((RANDOM % 10)) -eq 0 ]; then
        echo "A quantum fluctuation occurs!"
        COHERENCE=$(echo "$COHERENCE + 0.00001" | bc)
        echo "Coherence increased to: $COHERENCE"
    fi
    
    echo
    
    # Check win condition
    if [ $ROOM -eq 3 ] && [ $(echo "$COHERENCE >= 0.99999" | bc) -eq 1 ]; then
        echo "🎉 YOU FOUND THE FOLD ENTRY!"
        echo "FE-OGUF-P1 activated!"
        echo "You win!"
        exit 0
    fi
done

echo "Game over!"
EOF
chmod +x "$HOME/bin/aether-quest"

echo "✅ Games configured (type 'zork' or 'adventure' or 'aether-quest')"
