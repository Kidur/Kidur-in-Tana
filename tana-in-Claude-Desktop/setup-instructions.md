# Setting up Tana Read/Write Access in Claude Desktop

This guide helps you connect Tana Desktop to Claude Desktop so you can search and read your Tana nodes (in addition to writing via the native tana-mcp integration).

## Prerequisites

- Tana Desktop installed and running
- Claude Desktop installed
- One of: Mac, Windows, or Linux (Ubuntu/Fedora)

## Step 1: Enable Tana's Local MCP Server

1. Open **Tana Desktop**
2. Click **Options** (top left, fullscreen mode on Mac)
3. Click **Local API settings...**
4. Check the box: **Enable MCP**

That's it—Tana is now ready.

## Step 2: Run the Setup Script

Choose your operating system:

### Mac or Linux

Open **Terminal** and paste this command, then press Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/Kidur/Kidur-in-Tana/main/tana-in-Claude-Desktop/setup-tana-mcp.sh | bash
```

**Note:** Mac required some debugging during development. If you hit issues, email connect@evobiosys.org

### Windows

Open **PowerShell** (right-click → Run as Administrator) and paste:

```powershell
Invoke-WebRequest -Uri https://raw.githubusercontent.com/Kidur/Kidur-in-Tana/main/tana-in-Claude-Desktop/setup-tana-mcp.ps1 -OutFile setup-tana-mcp.ps1; powershell -ExecutionPolicy Bypass -File setup-tana-mcp.ps1
```

**Note:** Not yet tested on Windows. Please report issues to connect@evobiosys.org

## Step 3: Update Claude Desktop Config

1. Open **Claude Desktop**
2. Go to **Developer Settings** → **Edit Config**
3. Find the `"mcpServers"` section
4. Add this entry:

```json
"tana-remote": {
  "command": "/usr/local/bin/mcp-remote-v24",
  "args": ["http://localhost:8262/mcp"]
}
```

(On Windows, use `"command": "mcp-remote-v24"` instead)

5. Save the file (Cmd+S or Ctrl+S)

## Step 4: Restart Claude Desktop

- Quit Claude Desktop completely (⌘Q or Alt+F4)
- Reopen it

You should now have read and write access to Tana!

## Important Notes

- **"Set and forget":** The server doesn't need to stay running. However, this is not yet fully confirmed—if issues arise, try restarting Tana Desktop or the mcp-remote server.
- **Terminal doesn't need to stay open:** Once the setup script runs, you can close the terminal window
- **Tana native MCP:** You can have both the native `tana-mcp` (write-only) and `tana-remote` (read/write) configured at the same time

## Troubleshooting

- If mcp-remote can't be found: Ensure Node v24 is installed (`node -v` should return `v24.x.x`)
- If Claude Desktop says "Server disconnected": Restart both Tana Desktop and Claude Desktop
- Permission denied on the wrapper script: Try `sudo chmod +x /usr/local/bin/mcp-remote-v24`

## Questions or Issues?

Email: **connect@evobiosys.org**
