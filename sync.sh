#!/bin/bash
# sync.sh - 自动同步 Vault 到 GitHub
cd /root/Documents/laoli-content
git pull origin main --rebase 2>/dev/null
if [[ -n $(git status --porcelain) ]]; then
  git add .
  git commit -m "vault sync: $(date '+%Y-%m-%d %H:%M')"
  git push origin main
  echo "✅ 已同步"
else
  echo "无变更"
fi
