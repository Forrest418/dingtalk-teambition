#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
CONFIG_PATH="${SKILL_DIR}/mcporter.json"

if [[ ! -f "${CONFIG_PATH}" ]]; then
  echo "[resolve] 缺少配置文件: ${CONFIG_PATH}" >&2
  echo "[resolve] 请将用户提供的 mcporter.json 复制到技能目录。" >&2
  exit 1
fi

mcp() {
  mcporter --config "${CONFIG_PATH}" "$@"
}

# Priority:
# 1) first arg
# 2) common names: 钉钉项目管理 / dingtalk-teambition / teambition
# 3) auto-detect by typical PM tool names

is_server_ok() {
  local name="$1"
  local output
  output="$(mcp list "${name}" --schema --json 2>/dev/null || true)"
  echo "${output}" | jq -e '.status == "ok"' >/dev/null 2>&1
}

if [[ "${1:-}" != "" ]]; then
  if is_server_ok "$1"; then
    echo "$1"
    exit 0
  fi
  echo "[resolve] 指定服务不可用: $1" >&2
  exit 1
fi

for name in "钉钉项目管理" "dingtalk-teambition" "teambition"; do
  if is_server_ok "${name}"; then
    echo "${name}"
    exit 0
  fi
done

AUTO_NAME="$({
  mcp list --json 2>/dev/null \
  | jq -r '
      .servers[]
      | select(.status == "ok")
      | select(
          (any(.tools[]?; (.name | test("project|task|issue|workitem|story|sprint|iteration|board"; "i"))))
        )
      | .name
    ' \
  | head -n 1
} || true)"

if [[ "${AUTO_NAME}" != "" ]]; then
  echo "${AUTO_NAME}"
  exit 0
fi

echo "[resolve] 未找到可用的 Teambition MCP 服务。" >&2
echo "[resolve] 请检查技能目录下 mcporter.json 的 mcpServers 配置。" >&2
exit 1
