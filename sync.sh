#!/bin/bash
# sync.sh - 自动同步 Vault 到 GitHub
cd /root/Documents/laoli-content

# 同步 OpenClaw 核心配置到 Obsidian
WORKSPACE=/root/.openclaw/workspace
DEST=/root/Documents/laoli-content/OpenClaw配置
mkdir -p "$DEST"
for f in SOUL.md MEMORY.md AGENTS.md USER.md NOW.md; do
  [ -f "$WORKSPACE/$f" ] && cp "$WORKSPACE/$f" "$DEST/$f"
done

git pull origin main --rebase 2>/dev/null
if [[ -n $(git status --porcelain) ]]; then
  git add .
  git commit -m "vault sync: $(date '+%Y-%m-%d %H:%M')"
  git push origin main
  echo "✅ 已同步"
else
  echo "无变更"
fi
