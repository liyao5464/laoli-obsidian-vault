大家好，我是老里。

今天想跟你聊一件我亲手搭起来的东西——**AI内容工厂**。

不是那种"听起来很厉害但你根本用不上"的东西。是我今天花了两个多小时，一步一步真实搭起来的，中间踩了好几个坑，差点放弃。

---

## 从一篇文章开始

有人用 **OpenClaw + Obsidian** 搭了一套内容工厂，说可以实现7x24小时自动生产内容，单篇文章能卖到6000块。

我当时的反应是：吹牛吧？

有人用 **OpenClaw + Obsidian** 搭了一套内容工厂，说可以实现7x24小时自动生产内容，单篇文章能卖到6000块。

我当时的反应是：吹牛吧？

但越看越觉得这个架构设计得很聪明——

**Obsidian 当知识库**，把你所有的灵感、素材、文章都存在里面，双向链接，永不丢失。

**OpenClaw 当执行引擎**，7x24小时在后台跑，帮你抓素材、生成选题、写大纲、出初稿。

两个工具一结合，你维护的就不再是几十篇散落的文章，而是一台**不断自我强化的内容处理引擎**。

我决定自己搭一个试试。

---

## 然后我就开始踩坑了

### 坑一：搭完才发现，原文的方案根本不适用我

按照原文，我把服务器上的 Vault 建好了，目录结构也搭好了，软链接也连上了。

然后我问了一句：**那我本地的 Obsidian 怎么办？**

这才发现一个原文完全没提到的问题——

原文作者的 OpenClaw 是装在本地 Mac 上的。Obsidian 和 OpenClaw 在同一台机器，直接用软链接就搞定了，根本不存在"同步"这个问题。

但我的情况不一样：**OpenClaw 在云服务器上，Obsidian 在本地 Windows，两台机器。**

原文的方案，直接套不上。

我把这个问题抛给了 OpenClaw，它给了我一个解法：**用 GitHub 做中转**。

```
本地 OB ←→ GitHub repo ←→ 服务器 Vault
```

服务器每10分钟推一次，本地 OB 每5分钟拉一次，基本实时同步。

这个方案原文没有，是我们现场想出来的。

### 坑二：Windows 上的 curl 根本不是 curl

搭建过程中需要手动安装 obsidian-git 插件，我让 OpenClaw 给了我命令：

```
curl -L https://github.com/... -o main.js
```

粘进 PowerShell，直接报错：

```
Invoke-WebRequest : 找不到与参数名称"L"匹配的参数
```

搞了半天才明白：**Windows PowerShell 里的 `curl` 其实是 `Invoke-WebRequest` 的别名**，根本不支持 `-L` 参数。

正确写法是：

```powershell
Invoke-WebRequest -Uri "https://github.com/..." -OutFile "main.js"
```

Mac 用户永远不会踩这个坑，但 Windows 用户一定会。

### 坑三：obsidian-git 搜不到 + SSL 连接失败

装好插件，打开 Obsidian 插件市场搜 `obsidian-git`，什么都没有。

后来才发现：**Obsidian 默认开启"安全模式"，第三方插件全部屏蔽。**

要先去 设置 → 第三方插件 → 关闭安全模式，才能搜到。

装好之后，点 Push，又报错了：

```
fatal: schannel: failed to receive handshake, SSL/TLS connection failed
```

这是 Windows Git 的 SSL 后端问题，一行命令解决：

```powershell
git config --global http.sslBackend openssl
```

改完重新 Push，通了。

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
