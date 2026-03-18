# Tana in Claude Desktop Setup

This folder contains automated setup scripts to enable read/write access to Tana in Claude Desktop.

## Files

- **setup-tana-mcp.sh** - Setup script for Mac and Linux
- **setup-tana-mcp-linux.sh** - Setup script specifically for Linux (Ubuntu/Fedora)
- **setup-tana-mcp.ps1** - Setup script for Windows (PowerShell)
- **setup-instructions.md** - Complete setup guide with manual steps

## Quick Start

See `setup-instructions.md` for the one-liner commands for your OS.

## Important Reminder

After running the setup script, users will also need to **paste this configuration into Claude Desktop's config file**:

For Mac/Linux:
```json
"tana-remote": {
  "command": "/usr/local/bin/mcp-remote-v24",
  "args": ["http://localhost:8262/mcp"]
}
```

For Windows:
```json
"tana-remote": {
  "command": "mcp-remote-v24",
  "args": ["http://localhost:8262/mcp"]
}
```

This must be added to the `"mcpServers"` section of their Claude Desktop config file.

## Status

- ✅ Mac: Tested and working (required some debugging)
- ⚠️ Windows: Not yet tested
- ⚠️ Linux: Not yet tested

Questions or issues? Email: **connect@evobiosys.org**
