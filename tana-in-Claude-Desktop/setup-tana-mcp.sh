#!/bin/bash
# Tana + Claude Desktop MCP Setup Script for Mac/Linux
# This script installs Node.js v24, creates a wrapper for mcp-remote,
# and enables Tana read/write access in Claude Desktop

set -e

echo "🚀 Starting Tana MCP setup..."

# Check if nvm is installed
if ! command -v nvm &> /dev/null; then
    echo "📦 Installing nvm (Node Version Manager)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

echo "📥 Installing Node.js v24..."
nvm install 24
nvm alias default 24

echo "🔗 Creating mcp-remote wrapper script..."
sudo tee /usr/local/bin/mcp-remote-v24 > /dev/null << 'EOF'
#!/bin/bash
exec $HOME/.nvm/versions/node/v24.5.0/bin/node $HOME/.nvm/versions/node/v24.5.0/lib/node_modules/mcp-remote/dist/proxy.js "$@"
EOF

sudo chmod +x /usr/local/bin/mcp-remote-v24

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Enable MCP in Tana Desktop: Options → Local API settings → Enable MCP"
echo "2. Update Claude Desktop config with:"
echo '   "tana-remote": {'
echo '     "command": "/usr/local/bin/mcp-remote-v24",'
echo '     "args": ["http://localhost:8262/mcp"]'
echo "   }"
echo "3. Restart Claude Desktop"
echo ""
echo "Questions? Email: connect@evobiosys.org"
