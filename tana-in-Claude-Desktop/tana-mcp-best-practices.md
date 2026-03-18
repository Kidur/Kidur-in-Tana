# Tana MCP Best Practices for Claude

When working with Tana via Claude, follow these patterns to get reliable results.

## Workspace ID Scoping (CRITICAL)

**Rule:** Always scope with explicit `workspaceIds` in search queries. Defaults to "current" which is unreliable.

**Why:** Cross-workspace queries fail silently. Explicit IDs ensure you hit the right workspace.

**How to apply:**
- Ask Claude to `list_workspaces` once at the start to get the full workspace map
- Reference workspaces by name context when needed (e.g., "JaKaja <> MBerg" = MpVBvRvjSA2E)
- Always pass `workspaceIds: [...]` to search_nodes unless cross-workspace search is intentional

## Calendar Nodes

**Rule:** `get_or_create_calendar_node` requires an explicit workspaceId parameter.

**How to apply:**
- Default to Launchpad (34saXxFYBC) unless you specify otherwise
- If querying "today", no date parameter is needed
- Always include workspaceId even for the current workspace

## For Writes: Use import_tana_paste

This is the create/write tool. Use proper Tana Paste syntax:

- **Single tags:** `#tagname` or `#[[^tagID]]` (ID preferred)
- **Multi-value fields:** Indent children under parent
- **Fields:** `[[^fieldID]]:: value` format
- **Dates:** `[[date:2026-03-18]]` format
- **References:** `[[^nodeID]]` (exact node ID preferred)

## For Reads: Use search_nodes

Choose the right operator:
- `textContains` for fuzzy text search
- `childOf` for hierarchy queries (find nodes under a parent)
- `hasType` for tag-based queries
- **Always specify workspaceIds** unless cross-workspace is intentional (rare)

## For Edits: Use edit_node

Important constraints:
- Search-and-replace only (old_string must match exactly or edit fails)
- Works on node names and descriptions only
- For editing content/children, use import_tana_paste instead
- If old_string doesn't match, edit will fail—verify the exact text first

## Quick Checklist

Before any Tana operation:
- [ ] Do I need to specify workspaceId?
- [ ] Am I using the right tool? (search_nodes for read, import_tana_paste for write, edit_node for name/description)
- [ ] Do I have exact text matches for edit_node operations?
- [ ] Should I use node IDs instead of names for reliability?
