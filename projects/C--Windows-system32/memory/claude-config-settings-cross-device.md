---
name: claude-config-settings-cross-device
description: ~/.claude/settings.json syncs between two machines running different hook systems; merge by union, never by picking a side
metadata:
  type: project
---

`~/.claude` syncs to https://github.com/Yazeed-Alotaibi/claude-config (PUBLIC repo).
`settings.json` is shared by at least two machines that run **different hook systems**:

- **This PC (C--Windows-system32)** — Orca hooks: `conhost.exe` -> `%USERPROFILE%\.orca\agent-hooks\claude-hook.cmd`, on PreToolUse, PostToolUse, PostToolUseFailure, PermissionRequest, SessionStart, Stop, StopFailure, SubagentStart, SubagentStop, TeammateIdle, UserPromptSubmit.
- **Other device** — Paseo hooks: `paseo hooks claude <event>`, self-guarded by `$PASEO_TERMINAL_ID`, on UserPromptSubmit, Stop, StopFailure, SessionEnd, Notification.

**Why:** every `claude push` after the other device commits produces a `settings.json`
conflict. Picking one side silently deletes the other machine's hook automation, and on
2026-08-20 the local working copy had also gutted `enabledPlugins` from 21 entries to 1 —
so "keep local" would have wiped the whole plugin list too.

**How to apply:** resolve by **union**, not `--ours`/`--theirs`:
- `hooks` — concatenate entries per event (both systems coexist; Paseo no-ops without its env var)
- `enabledPlugins`, `extraKnownMarketplaces`, `env` — dict-merge, local wins on key collision
- `statusLine` and `theme` — single-valued, cannot union. Keep **this machine's** value
  (coralline PowerShell statusline, dark). These are genuinely per-machine and arguably
  should not be synced at all.
- Generated churn (`.claude-flow/**`, `proven-config.json`) — take `--theirs`, it regenerates.

Also: repo is public, so scan for secrets before `git add -A`. `.gitignore` already blocks
`projects/**` transcripts except `projects/**/memory/**`.

Related: [[prefers-verified-status-recaps]]
