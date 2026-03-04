# Tool Discovery

## Goal

Select correct Teambition tool names at runtime for the connected MCP deployment.

## Commands

List full schema:

```bash
SERVER="$(scripts/resolve_server.sh)"
mcporter --config ./mcporter.json list "$SERVER" --schema --json | jq '.'
```

Quick filter for project management tools:

```bash
SERVER="$(scripts/resolve_server.sh)"
mcporter --config ./mcporter.json list "$SERVER" --schema --json \
| jq -r '.. | objects | select(has("name") or has("id")) | [.id // .name, .description // ""] | @tsv' \
| rg -i "project|task|story|bug|issue|board|sprint|iteration|milestone|workitem|项目|任务|需求|缺陷|看板|迭代|里程碑|工时"
```

## Mapping Heuristics

- Project list/details: name includes `project`
- Task query/update: name includes `task|issue|workitem|story|bug`
- Sprint/iteration view: name includes `sprint|iteration`
- Board status: name includes `board|kanban`
- Worklog/time tracking: name includes `worklog|time|hour`

## Safety

Before using tools with `create`/`update`/`delete`:

1. Ask user confirmation.
2. Echo target object ids before execution.
3. Prefer read-only equivalent when available.
