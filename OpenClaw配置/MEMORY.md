# MEMORY.md - 长期记忆（硬限100行）

## 核心规则

- 发文章前必问：发主号还是实验室？
- 发布流程：直接用wechat-api.ts发布.md文件
- 配图方式：图片放articles/images/，markdown中用`images/img-XX.png`引用
- wechat-api.ts自动上传图片并替换URL
- 封面提示词要简洁
- 写文章前必读 `writing-guide.md` + `style-agent.md`
- 发布主题：默认 claude 主题

## 双账号

| 账号 | AppID | AppSecret |
|------|-------|-----------|
| 主号 | wxbde0f982acfe271b | a561d22a1227a810d66f13efa19bedb1 |
| 小号 | wx22983d127a8ee206 | ea1ea206e7f690a3b87f153dabc56770 |

主号=AI科普 / 小号=工具类

## 写作风格索引

- 风格文件：`style-agent.md` + `writing-guide.md`
- 核心：接地气，朋友聊天语气
- 开头："大家好，我是老里"
- 结尾：固定"感恩三连"模板
- 禁止：书面腔、被动句、AI味

## Agent团队（10个）

| agentId | 名字 | 职责 |
|---------|------|------|
| main | 小助里🦐 | 统筹全局 |
| director | 内容总监✍️ | 选题推送 |
| libi | 李笔📝 | Twitter |
| liwei | 李微📱 | 朋友圈 |
| coder | AI工程师💻 | 编程 |
| nanny | 育儿师👶 | 育儿 |
| video-director | 视频总监🎬 | 视频 |
| huatuo | AI华佗🏥 | 运维 |
| swjc | 赛博诸葛🧙 | 策略 |
| xhs | 小红书运营📷 | 小红书 |

联系：`sessions_send(agentId="xxx", message="...")`

## 知识库索引

> 详见 `memory/INDEX.md`，按需加载

| 类型 | 路径 |
|------|------|
| 人物画像 | `memory/people/laoli-profile.md` |
| 用户偏好 | `memory/preferences/laoli-preferences.md` |
| 朋友圈偏好 | `memory/preferences/moments-preferences.md` |
| 发布经验 | `memory/lessons/wechat-publishing.md` |
| 写作方法论 | `memory/lessons/writing-methodology.md` |
| 记忆架构 | `memory/lessons/openclaw-memory-arch.md` |
| 双账号决策 | `memory/decisions/2026-02-14-dual-accounts.md` |
| 微信抓取 | `memory/lessons/wechat-article-scraping.md` |
| 配图技巧 | `memory/lessons/image-generation-tips.md` |
| 朋友圈格式 | `memory/lessons/moments-send-format.md` |

## 冷存储索引

| 内容 | 路径 |
|------|------|
| 发布命令 | `archive/publish-playbook.md` |
| 发布配置 | `archive/publish-config.md` |
| 配图流程 | `archive/illustration-playbook.md` |
| ePro方法论 | `archive/epro-memory-guide.md` |

## 踩坑记录

- ❌ 发错号
- ❌ 封面提示词太复杂→超时
- ❌ 忘删备用标题→失败
- ❌ 上下文压缩丢指令

## 操作铁律

### openclaw.json 修改
- 改前备份：`cp openclaw.json openclaw.json.bak.$(date +%Y%m%d%H%M%S)`
- 改前查文档
- 改后验证：JSON + `openclaw doctor`

### 禁止危险操作
- ❌ kill + systemd start
- ❌ stop+start 快速连击
- ✅ `openclaw gateway restart`

### 其他铁律
- 不猜命令/配置，先查文档
- 给选项后必须等确认
- 不暴露密钥，用 1Password `op`
- op 操作必须在 tmux 里
- 代码变更：本地改→测试→commit→确认→部署
