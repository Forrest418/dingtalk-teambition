# dingtalk-teambition

通用钉钉 Teambition 项目管理技能（Skill），用于通过 MCP 查询项目、任务、迭代、看板等信息。

## 功能

- 项目列表/详情查询
- 任务检索与状态统计
- 迭代（Sprint）与看板跟踪
- 需求/缺陷/阻塞项盘点

## 快速开始

1. 准备配置文件

将你的 MCP 配置保存为仓库根目录 `mcporter.json`。

你可以先复制示例文件：

```bash
cp mcporter.example.json mcporter.json
```

2. 验证配置

```bash
./scripts/preflight.sh
./scripts/discover_tools.sh
```

3. 开始调用

```bash
SERVER="$(./scripts/resolve_server.sh)"
mcporter --config ./mcporter.json call "${SERVER}.<tool>" key:value --output json
```

## 配置文件示例

文件路径：`./mcporter.json`

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

## 常用命令

解析服务名：

```bash
./scripts/resolve_server.sh
```

查看可用工具：

```bash
./scripts/discover_tools.sh
```

按 schema 调用工具（示例）：

```bash
SERVER="$(./scripts/resolve_server.sh)"
mcporter --config ./mcporter.json call "${SERVER}.<task-tool>" keyword:"支付" --output json
```

## 排障

- 提示缺少 `mcporter.json`：把配置文件放到仓库根目录。
- 提示服务不可用：检查 URL 与 key 是否有效。
- 查不到工具：先运行 `./scripts/discover_tools.sh`，确认服务返回了工具列表。

## 安全说明

- `mcporter.json` 可能包含敏感 key，请勿提交到公共仓库。
- 仓库通过 `.gitignore` 忽略 `mcporter.json`。

## 仓库结构

```text
.
├── SKILL.md
├── README.md
├── mcporter.example.json
├── references
│   ├── configuration.md
│   └── tool-discovery.md
└── scripts
    ├── resolve_server.sh
    ├── preflight.sh
    └── discover_tools.sh
```
