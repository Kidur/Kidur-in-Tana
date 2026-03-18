# Tana + Claude Desktop MCP Setup Script for Windows
# This script installs Node.js v24 and creates a wrapper for mcp-remote
# Note: Not yet tested on Windows - please report issues to connect@evobiosys.org

Write-Host "🚀 Starting Tana MCP setup..."
Write-Host ""
Write-Host "⚠️  Note: This setup script has not yet been tested on Windows."
Write-Host "Please report any issues to connect@evobiosys.org"
Write-Host ""

# Check if nvm-windows is installed
if (!(Test-Path "$env:APPDATA\nvm")) {
    Write-Host "📦 nvm-windows not found. Please install it first:"
    Write-Host "   1. Download from: https://github.com/coreybutler/nvm-windows/releases"
    Write-Host "   2. Run the installer"
    Write-Host "   3. Close PowerShell and reopen"
    Write-Host "   4. Run this script again"
    exit
}

Write-Host "📥 Installing Node.js v24..."
nvm install 24.5.0
nvm use 24.5.0

Write-Host "🔗 Creating mcp-remote wrapper script..."

# Determine paths
$appDataPath = $env:APPDATA
$npmPath = "$appDataPath\npm"
$wrapperPath = "$npmPath\mcp-remote-v24.cmd"
$nodeModulesPath = "$npmPath\node_modules\mcp-remote\dist\proxy.js"

# Get Node path
$nodePath = (Get-Command node.exe).Source

# Create wrapper batch file
$wrapperContent = @"
@echo off
"$nodePath" "$nodeModulesPath" %*
"@

Set-Content -Path $wrapperPath -Value $wrapperContent -Force

Write-Host ""
Write-Host "✅ Setup complete!"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Enable MCP in Tana Desktop: Options → Local API settings → Enable MCP"
Write-Host "2. Update Claude Desktop config with:"
Write-Host '   "tana-remote": {'
Write-Host '     "command": "mcp-remote-v24",'
Write-Host '     "args": ["http://localhost:8262/mcp"]'
Write-Host "   }"
Write-Host "3. Restart Claude Desktop"
Write-Host ""
Write-Host "Questions? Email: connect@evobiosys.org"
