---
name: dingtalk-teambition
description: 通用钉钉 Teambition 项目管理技能。用户提到“项目管理/任务/迭代/看板/需求/缺陷/里程碑/工时/Teambition”时使用。通过本技能调用 MCP 服务进行工具发现和项目查询；用户只需在技能目录维护 mcporter.json。
homepage: https://mcp.dingtalk.com
metadata:
  openclaw:
    emoji: "📋"
    requires:
      bins: ["mcporter", "jq"]
---

# DingTalk Teambition

Use this skill to query and operate Teambition project-management data through a configurable MCP server.

## User-Maintained Config (Only)

Users only need to maintain:

- MCP JSON config file in skill root: `mcporter.json`
- Streamable HTTP URL (required)

See `references/configuration.md` for setup.

At runtime, resolve server name with:

```bash
SERVER="$(scripts/resolve_server.sh)"
```

## Execution Policy

- Run locally with `exec`/shell only.
- Perform tool discovery before first project/task call.
- Always call MCP through `scripts/mcp.sh` (never call raw `mcporter` directly), to avoid accidentally using workspace default config.
- Use canonical call format (function syntax, compatible with server names containing spaces):
  - `scripts/mcp.sh call "${SERVER}.<tool>(arg: \"value\")" --output json`
- Prefer read-only calls. Ask user confirmation before create/update/delete operations.
- If result is empty, report no-match and suggest broader keywords.

## Session Cache Recovery (OpenClaw)

If user reports `Teambition not configured` and the path points to `~/.openclaw/workspace/config/mcporter.json`, treat it as stale session cache first (not config-file content issue).

Recovery order:

1. Start a fresh session and retry.
2. If still stale, clear DingTalk session keys in `~/.openclaw/agents/main/sessions/sessions.json` and restart gateway.

## Preflight

```bash
scripts/preflight.sh
```

## Discover Available Tools

```bash
scripts/discover_tools.sh
```

Then select actual tool names from schema because deployments may vary.

## Common Workflows

### 1) Find Projects

```bash
SERVER="$(scripts/resolve_server.sh)"
scripts/mcp.sh call "${SERVER}.get_user_projects(pageSize: 5)" --output json
```

### 2) Query Tasks by Keyword/Person/Sprint

```bash
SERVER="$(scripts/resolve_server.sh)"
# Replace selector and args according to discovered schema
scripts/mcp.sh call "${SERVER}.<task-search-tool>(keyword: \"登录\")" --output json
```

### 3) Build Daily Snapshot (Read-Only)

1. List projects and target boards/sprints.
2. Pull task statistics (todo/doing/done/blocked).
3. Summarize risk items and pending owners.

## Output Guidelines

- Always include tool selector names in summary for traceability.
- Prefer compact tables: `project | sprint | task | owner | status | due`.
- If fields are noisy, keep only actionable columns.
- Mask personal contact fields unless user explicitly asks full values.

## References

- Config setup: `references/configuration.md`
- Tool discovery strategy: `references/tool-discovery.md`
