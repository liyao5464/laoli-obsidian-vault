# Obsidian+OpenClaw 组合技

> 来源：飞书知识库 - WayToAGI
> 标题：Obsidian+OpenClaw组合技！花9分钟重构你的AI知识管理体系
> 作者：卡尔
> 链接：https://waytoagi.feishu.cn/wiki/FcuFwvsGDiuAgYks0nvcc77inBd

---

## 核心理念

解决两个问题：
1. 怎么让信息流动到 Obsidian 里
2. 怎么让 Obsidian 里存的信息有合理结构，让 AI 和自己都能看懂

---

## 工具链

| 工具 | 作用 |
|------|------|
| Obsidian | Markdown 笔记管理 |
| Claude Code / Codex App | 本地 AI 侧边栏 |
| 笔记同步助手 | 同步微信消息到 Obsidian |
| Obsidian Web Clipper | 网页剪藏（公众号、视频） |
| OpenClaw | 啃硬骨头（难解析的链接和视频） |

---

## 信息收录三大类

1. **插件**：笔记同步助手
2. **微信**：笔记同步助手
3. **OpenClaw**：专门啃难解析的链接和视频

---

## 安装步骤

### 1. 联网搜索 + 链接解析
```
帮我安装
x-reader： https://github.com/runesleo/x-reader
Agent Reach
browserwing
```

### 2. Obsidian 打通
```
npx clawhub@latest install obsidian
```

### 3. 找技能
```
npx clawhub@latest install find-skills
```

### 4. 主动 Agent
```
npx clawhub install proactive-agent-1-2-4
```

### 5. 软链接（核心！）
> 建一个软链接，把工作区连接到 Obsidian 仓库

```
帮我建一个软链接，把你的工作区链接到我的Obsidian仓库里，建一个叫「OpenClaw配置」的文件夹
```

---

## 核心洞察

> "用久了我发现同一份数据，OpenClaw 会划分总结沉淀出合适的知识点分开几个地方储存。刚开始我不清楚为什么它选择这样做，但是用下来发现它是对的。我不需要时刻回顾信息的来源，我只管用就好了，来源是 AI 自己记忆用的。"

---

## 关联

- [[OpenClaw技巧]]
- [[知识管理]]
