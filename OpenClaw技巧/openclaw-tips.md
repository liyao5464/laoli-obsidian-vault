# OpenClaw 技巧大全

*持续更新中...*

---

## 配置技巧

### 1. 新手不要手改配置文件

- 先用官方默认模型（MiniMax/智谱）跑通
- 不要自己写 JSON，让向导帮你生成
- 改 key 比改结构安全得多

详见：`openclaw-config-tips.md`

### 2. JSON 报错排查

常见错误：
- 多一个逗号、少一个冒号
- 缩进乱掉
- 路径里有反斜杠 `\` 要改成 `/`

---

## 多模型多实例

### 为什么要多实例？

- 一个实例出问题，切换另一个
- 64G 内存可以跑 10 个实例
- 每个实例内存约 500MB

### 推荐配置

| 实例 | 模型 | 用途 |
|------|------|------|
| main | MiniMax M2.5 | 日常对话 |
| coder | Claude Opus 4.6 | 编程开发 |
| director | MiniMax M2.5 | 内容策划 |

---

## 跨分身通讯

### 配置方法

在 `openclaw.json` 中为每个 agent 添加：

```json
{
  "id": "director",
  "subagents": {
    "allowAgents": ["main"]
  }
}
```

main 需要能派任务给其他分身。

### 使用方法

```python
sessions_send(agentId="director", message="帮我筛选选题")
```

---

## 内存与压缩

### 上下文压缩

- 触发条件：token 接近上限
- 自动保存：重要信息会写入 memory/
- 软阈值：4000 tokens 触发提醒

### 减少 token 技巧

- 用 `smart-memory` 技能
- 只加载当前需要的知识
- 定期清理不用的上下文

---

## 技能生态

### 推荐技能

| 技能 | 用途 |
|------|------|
| wechat-fetcher | 抓取公众号文章 |
| deepwork-tracker | 深度工作计时 |
| weather | 天气查询 |
| search | 网页搜索 |
| blog-post-writer | 公众号写作 |

### 安装技能

```bash
clawdbot config patch skills.entries.xxx enabled=true
```

---

## 常见问题

### Q: Gateway 启动报错

A: 检查 JSON 语法，用 `openclaw gateway doctor` 诊断

### Q: 模型不响应

A: 切换到备用实例，检查 API key 是否过期

### Q: 上下文丢失

A: 检查压缩是否触发，memory 文件是否正常保存

---

## 每日检查

- HEARTBEAT.md 记录待办
- 定期备份 workspace
- 检查各实例状态

---

*有问题？直接在群里问 🦐*
