#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
CONFIG_PATH="${SKILL_DIR}/mcporter.json"
SERVER="$(${SCRIPT_DIR}/resolve_server.sh "${1:-}")"

SCHEMA_JSON="$(mcporter --config "${CONFIG_PATH}" list "${SERVER}" --schema --json)"

echo "${SCHEMA_JSON}" | jq -e '.status == "ok" and (.tools | type == "array")' >/dev/null

echo "${SCHEMA_JSON}" \
| jq -r '.tools[]? | [.name, (.description // "")] | @tsv' \
| rg -i "project|task|story|bug|issue|board|sprint|iteration|milestone|workitem|项目|任务|需求|缺陷|看板|迭代|里程碑|工时" || true
