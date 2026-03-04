# Configuration

## Goal

Place one JSON file in the skill directory and start using the skill.

## Single-Step Setup

Put this file at:

- `./mcporter.json` (skill root)

```json
{
  "mcpServers": {
    "钉钉项目管理": {
      "type": "streamable-http",
      "url": "https://mcp-gw.dingtalk.com/server/<serverId>?key=<key>"
    }
  }
}
```

Notes:

- Replace `url` with your own MCP URL.
- Service name can be any value; `钉钉项目管理` is recommended.
- If you already have an existing `mcporter.json`, merge this server into `mcpServers`.

## Verify

```bash
./scripts/preflight.sh
./scripts/discover_tools.sh
```

Expected:

- Preflight prints `ok`
- Discovery prints project/task-related tools

## OpenClaw Notes

- If responses keep saying Teambition is not configured and show `~/.openclaw/workspace/config/mcporter.json`, check session cache before touching any `mcporter.json`.
- First try a fresh session; if needed, clear DingTalk session keys in `~/.openclaw/agents/main/sessions/sessions.json` and restart gateway.
