#!/bin/bash
# Firefox setup for Aether Orchestrator

echo "🌐 Configuring Firefox..."

# Create Firefox profile with orchestrator bookmark
mkdir -p "$HOME/.mozilla/firefox/profiles"

# Create a simple bookmarks file
cat > "$HOME/.mozilla/firefox/profiles/bookmarks.html" << 'EOF'
<!DOCTYPE NETSCAPE-Bookmark-file-1>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<TITLE>Bookmarks</TITLE>
<H1>Bookmarks</H1>
<DL>
    <DT><A HREF="http://localhost:3000">Aether Orchestrator Portal</A>
    <DT><A HREF="http://localhost:8080/health">Orchestrator Health</A>
    <DT><A HREF="https://github.com/onegayunicorn/aether-grid">GitHub Repository</A>
    <DT><A HREF="https://github.com/onegayunicorn/aether-userland-package">UserLand Package</A>
</DL>
EOF

echo "✅ Firefox configured with orchestrator bookmarks"
echo "💡 Open Firefox and check your bookmarks!"
