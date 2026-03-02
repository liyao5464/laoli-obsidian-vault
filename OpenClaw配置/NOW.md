# NOW.md - 2026-03-02

## 今日重点

- [x] 破局赏金猎人文章完成（~5000字）
- [x] OpenClaw Guardian 安装 + Telegram 告警
- [x] Vault 同步时间优化（白天2h，晚上6h）
- [x] 操作铁律同步到所有分身

## 待处理

- 视频剪辑技能安装待测试
- 文章发布（破局活动提交）

## 灵感/决策

- Obsidian + OpenClaw 通过 sync.sh 复制配置同步
- Telegram token 在 openclaw.json，config.json 只有 Discord

## 2026-03-02 关键教训

- GitHub push protection：删 env 块，不是脱敏
- cron 表达式分段：0 0-15/2,16-23/6 * * *
- pkill -f 慎用，会杀当前 shell
