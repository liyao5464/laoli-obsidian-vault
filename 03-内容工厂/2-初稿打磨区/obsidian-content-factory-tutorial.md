大家好，我是老里。

今天想跟你聊一件我亲手搭起来的东西——**AI内容工厂**。

不是那种"听起来很厉害但你根本用不上"的东西。是我今天花了两个多小时，一步一步真实搭起来的，中间踩了好几个坑，差点放弃。

---

## 先说说我的痛点

我写公众号有一段时间了，文章也发了几十篇。

但有一个问题一直困扰我：**每次让AI帮我写新文章，它都像第一次见我一样。**

不知道我的写作风格，不知道我写过什么话题，不知道我上周收藏了哪篇好文章。

我的素材散落在各处——有的在微信收藏，有的在备忘录，有的在某个文件夹里，再也找不到了。

每次写文章，都要重新"教"AI一遍。

这他妈也太低效了。

---

## 然后我看到了这篇文章

有人用 **OpenClaw + Obsidian** 搭了一套内容工厂，说可以实现7x24小时自动生产内容，单篇文章能卖到6000块。

我当时的反应是：吹牛吧？

但越看越觉得这个架构设计得很聪明——

**Obsidian 当知识库**，把你所有的灵感、素材、文章都存在里面，双向链接，永不丢失。

**OpenClaw 当执行引擎**，7x24小时在后台跑，帮你抓素材、生成选题、写大纲、出初稿。

两个工具一结合，你维护的就不再是几十篇散落的文章，而是一台**不断自我强化的内容处理引擎**。

我决定自己搭一个试试。

---

## 然后我就开始踩坑了（Windows 用户专属）

### 坑一：Windows 上的 curl 根本不是 curl

搭建过程中需要手动安装一个插件，我让AI给了我一行命令：

```
curl -L https://github.com/... -o main.js
```

我直接粘进 PowerShell，报错了。

```
Invoke-WebRequest : 找不到与参数名称"L"匹配的参数
```

搞了半天才明白：**Windows PowerShell 里的 `curl` 其实是 `Invoke-WebRequest` 的别名**，根本不支持 `-L` 这个参数。

正确的写法是：

```powershell
Invoke-WebRequest -Uri "https://github.com/..." -OutFile "main.js"
```

这个坑，Mac 用户永远不会踩，但 Windows 用户一定会踩。

### 坑二：obsidian-git 插件搜不到

我打开 Obsidian，进插件市场，搜 `obsidian-git`，什么都没有。

以为是网络问题，刷新了好几次，还是没有。

后来才发现：**Obsidian 默认开启"安全模式"，第三方插件全部屏蔽。**

要先去 设置 → 第三方插件 → 关闭安全模式，才能搜到。

### 坑三：定时任务一直报错

我设置了一个每10分钟自动同步的定时任务，结果一直失败，报错信息是：

```
LLM request rejected: We're unable to verify your membership benefits at this time.
```

查了半天，原来是**模型权限问题**。

OpenClaw 的定时任务在隔离环境里运行，默认模型（newcli/claude-sonnet）在这个环境里验证不了会员资格。

解决方法：把定时任务的模型改成 `minimax/MiniMax-M2.5`，问题立刻消失。

---

## 好，踩坑说完了，下面是保姆级搭建步骤

我把整个过程拆成5步，按顺序来，不会出错。

**你需要准备的东西：**
- 一台云服务器（已经装好 OpenClaw）
- 本地电脑（Windows 或 Mac）
- 一个 GitHub 账号

---

### 第一步：在服务器上建 Vault

SSH 进你的服务器，运行：

```bash
# 安装 obsidian-cli
npm install -g obsidian-cli

# 建 Vault 目录结构
mkdir -p ~/Documents/laoli-content/{01-灵感与素材库/{1-日常灵感剪报,2-爆款素材片段},02-选题池/待写选题库,03-内容工厂/{1-大纲挑选区,2-初稿打磨区,3-终稿确认区},04-已发布归档/公众号已发布}

# 建软链接，让 OpenClaw workspace 能访问 Vault
ln -sf ~/Documents/laoli-content ~/.openclaw/workspace/laoli-content
```

目录结构长这样：

```
laoli-content/
├── 01-灵感与素材库/
│   ├── 1-日常灵感剪报/      ← 存你抓取的好文章
│   └── 2-爆款素材片段/      ← 存金句、框架、爆款结构
├── 02-选题池/
│   └── 待写选题库/          ← 存待写的选题
├── 03-内容工厂/
│   ├── 1-大纲挑选区/        ← AI生成的大纲在这里等你选
│   ├── 2-初稿打磨区/        ← 初稿在这里
│   └── 3-终稿确认区/        ← 你改完的终稿
└── 04-已发布归档/
    └── 公众号已发布/        ← 发布后归档
```


### 第二步：连接 GitHub

去 GitHub 新建一个 private repo（名字随意，比如 `laoli-obsidian-vault`），然后在服务器上：

```bash
cd ~/Documents/laoli-content
git init
git config user.name "你的名字"
git config user.email "你的邮箱"

# 用带 token 的地址，不用每次输密码
git remote add origin https://你的token@github.com/你的用户名/laoli-obsidian-vault.git

git add .
git commit -m "init: vault structure"
git push -u origin main
```

GitHub token 在哪里拿？Settings → Developer settings → Personal access tokens → 生成一个，勾上 `repo` 权限就行。

---

### 第三步：本地 Obsidian 连上来

在本地电脑克隆 repo：

```powershell
# Windows PowerShell
git clone https://github.com/你的用户名/laoli-obsidian-vault.git $env:USERPROFILE\Documents\laoli-content
```

然后打开 Obsidian → 打开本地仓库 → 选这个文件夹。

---

### 第四步：装 obsidian-git 插件

**注意：先关安全模式！**

设置 → 第三方插件 → 关闭安全模式 → 浏览 → 搜索 `obsidian-git` → 安装 → 启用

如果搜不到，用手动安装（Windows PowerShell）：

```powershell
cd "$env:USERPROFILE\Documents\laoli-content\.obsidian\plugins"
mkdir obsidian-git
cd obsidian-git
Invoke-WebRequest -Uri "https://github.com/denolehov/obsidian-git/releases/latest/download/main.js" -OutFile "main.js"
Invoke-WebRequest -Uri "https://github.com/denolehov/obsidian-git/releases/latest/download/manifest.json" -OutFile "manifest.json"
```

装完重启 OB，在插件列表里启用。

插件设置：
- Auto pull interval：`5`（分钟）
- Auto push interval：`5`（分钟）
- Commit message：`vault sync: {{date}}`


### 第五步：设置服务器自动推送

在服务器上创建同步脚本：

```bash
cat > ~/Documents/laoli-content/sync.sh << 'EOF'
#!/bin/bash
cd ~/Documents/laoli-content
git pull origin main --rebase 2>/dev/null
if [[ -n $(git status --porcelain) ]]; then
  git add .
  git commit -m "vault sync: $(date '+%Y-%m-%d %H:%M')"
  git push origin main
fi
EOF
chmod +x ~/Documents/laoli-content/sync.sh
```

然后在 OpenClaw 里加定时任务：

```bash
openclaw cron add --name "Vault自动同步GitHub" --cron "*/10 * * * *" --message "执行 bash ~/Documents/laoli-content/sync.sh"
```

**重要：** 加完之后必须改模型，不然会报权限错误：

```bash
# 查 job id
openclaw cron list | grep Vault

# 改模型
openclaw cron edit <job-id> --model minimax/MiniMax-M2.5
```

---

## 验证链路是否通了

在服务器上推一个测试文件：

```bash
echo "# 测试同步" > ~/Documents/laoli-content/test.md
cd ~/Documents/laoli-content && git add . && git commit -m "test" && git push origin main
```

然后在本地 OB 里点 **Pull**，看到 `test.md` 出现就说明全通了。验证完删掉就行。

---

## 搭好之后怎么用

链路通了之后，日常操作就这几个：

**收到好文章** → 把链接发给 OpenClaw，说"存进灵感库"，它自动抓取整理，10分钟内同步到你本地 OB

**想写文章** → 说"今天写什么"，OpenClaw 从选题池里给你列出来选

**确认选题** → 它检索素材库，出3个大纲角度，你选一个

**确认大纲** → 它写初稿，文件直接出现在你的 OB 里

**改完发布** → 告诉它"发布了"，它帮你归档

---

## 最后说一句

搭这套系统之前，我的文章是散的，素材是散的，AI每次都要重新教。

搭完之后，感觉不一样了。

每篇文章都有迹可循，每条素材都有地方落，AI越用越懂你。

就像那篇文章里说的那句话：

> 你维护的不再是几百篇散落的文章，而是一台7x24小时不间断吸收外部信息、不断自我强化的内容处理引擎。

这台引擎，今天算是正式启动了。

---

以上，既然看到这里了，如果觉得不错，
随手点个赞、在看、转发三连吧，
如果想第一时间收到推送，也可以给我个星标⭐️～
感谢你看我的文章，我们，下次再见。
