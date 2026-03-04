# dingtalk-teambition

面向 OpenClaw 的钉钉 Teambition 技能，支持项目管理**读写**能力。


## 帮助与支持
https://forreststudio.feishu.cn/drive/folder/Ma3Rf6gOclsxDQdpR7Aci8aCnbc

## 支持能力

- 读取：项目列表/详情、任务详情、项目成员、任务状态、工时查询
- 写入：创建项目、创建任务、更新任务状态/优先级/标题、分配执行人、添加评论、更新备注、填写工时
- 建议：涉及写入时，先让助手复述将要修改的对象和字段，再确认执行

## 第一步：配置

把下面 JSON 保存为 `mcporter.json`，放到技能目录根路径。

如果你使用 OpenClaw 默认技能目录，路径通常是：
`~/.openclaw/skills/dingtalk-teambition/mcporter.json`

```json
{
  "mcpServers": {
    "钉钉Teambition 项目管理": {
      "type": "streamable-http",
      "url": "https://mcp-gw.dingtalk.com/server/<serverId>?key=<key>"
    }
  }
}
```

## 第二步：验证

重启openclaw

## 第三步：开始使用

直接在 OpenClaw 对话中提需求即可。

读取示例：

- `查一下我能看到几个 Teambition 项目`
- `列出前 10 个项目名称`
- `查询任务 <任务ID> 的详情和当前状态`

写入示例：

- `在项目 <项目ID> 下创建任务：标题“支付联调”，负责人“张三”，截止“2026-03-10”`
- `把任务 <任务ID> 状态改为“进行中”`
- `给任务 <任务ID> 添加评论：“已完成接口联调”`



## 相关技能仓库

- dingtalk-contacts: https://github.com/Forrest418/dingtalk-contacts
- dingtalk-teambition: https://github.com/Forrest418/dingtalk-teambition
- dingtalk-chatgroup: https://github.com/Forrest418/dingtalk-chatgroup
- dingtalk-calendar: https://github.com/Forrest418/dingtalk-calendar
- dingtalk-attendance: https://github.com/Forrest418/dingtalk-attendance
- dingtalk-videomeeting: https://github.com/Forrest418/dingtalk-videomeeting
- dingtalk-amap: https://github.com/Forrest418/dingtalk-amap
