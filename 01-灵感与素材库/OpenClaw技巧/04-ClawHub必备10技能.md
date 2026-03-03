# ClawHub 必备10个技能

> 来源：鸟哥 | 蓝鸟会
> 链接：https://x.com/NFTCPS/status/2028366524201705794

---

## ClawHub 是什么

ClawHub 是 OpenClaw 的官方技能市场（AI Agent 的"插件商店"），目前已有上万个 Skills，能让你的本地 Agent 秒变生产力怪物。

**注意**：生态野蛮生长，也藏了不少恶意/垃圾 skill，先装安全扫描再下手才是正解！

---

## 必备10技能（2026年3月）

### 1️⃣ Skill Vetter - 安全审计技能
**保命第一！** 安装前自动扫描潜在恶意指令，ClawHub 雷区太多，别手快。

### 2️⃣ Tavily-search / SerpAPI - 联网搜索
解锁实时联网。没有它 Agent 就是信息孤岛，查最新资讯全靠它。

### 3️⃣ Browser / Playwright - 浏览器自动化
自己打开网页、点击、填表、截图。爬取、抢购、表单提交神器。

### 4️⃣ Code Interpreter - Python 执行环境
写代码、数据分析、绘图、文件处理。复杂任务几乎都依赖这个。

### 5️⃣ File Manager - 文件读写操作
本地文件增删改查、批量改名、PDF 解析。没有它 Agent 只能空想。

### 6️⃣ GitHub Assistant - Git 操作技能
commit、PR、issue、代码 review 一条龙。程序员的数字实习生就靠它。

### 7️⃣ Notion / Obsidian - 知识库操作
自动创建/更新/查询笔记，把 Agent 变成你的第二大脑。

### 8️⃣ Cron / Scheduler - 定时任务
每天自动跑日报、周报、监控、提醒。从被动工具→主动员工的质变。

### 9️⃣ Self-Improving / Evolver - 自我迭代
分析失败日志、自动优化 prompt 和策略。越用越聪明的"数字生命"感。

### 🔟 Daily Digest - 主动日报总结
每天自动发工作总结、待办、新闻精选、K线提醒。从工具变成"有心"的 AI 伙伴。

---

## 推荐安装顺序

**安全 → 联网 → 浏览器 → 代码 → 文件 → Git → 知识库 → 定时 → 自我进化 → 主动日报**

先把前4件套装好，再按需扩展。

---

## 一键安装命令

```bash
# 推荐顺序，一条条执行（或复制粘贴多行）
clawhub install skill-vetter
clawhub install tavily-search
clawhub install playwright-browser
clawhub install code-interpreter
clawhub install file-manager
clawhub install github-assistant
clawhub install notion-connector
clawhub install cron-scheduler
clawhub install self-improving
clawhub install daily-digest
```

**安装完记得重启 OpenClaw 会话，新技能才会生效。**

---

## 注意事项

- 安装前多看评论和下载量，避免踩雷
- 先确保已全局安装 clawhub CLI：`npm i -g clawhub` 或 `npx clawhub@latest`

---

## 关联

- [[OpenClaw新手避坑指南]]
- [[联网搜索Skills配置]]
