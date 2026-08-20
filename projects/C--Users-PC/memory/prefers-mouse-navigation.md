---
name: prefers-mouse-navigation
description: "User navigates Claude Code menus by mouse, not keyboard; fullscreen TUI rendering is enabled"
metadata: 
  node_type: memory
  type: user
  originSessionId: 1248590f-1bce-4597-b201-65d44188ec14
  modified: 2026-08-13T08:30:48.727Z
---

The user prefers clicking over keyboard navigation for Claude Code menus (slash-command autocomplete, select menus, option lists). On 2026-08-13 they set `CLAUDE_CODE_NO_FLICKER=1` as a persistent Windows user environment variable to enable fullscreen rendering, which is what makes those menus clickable.

**How to apply:** Don't explain arrow-keys/Enter flows as the only way to pick an option. Assume menus are clickable. If mouse interaction stops working, the likely cause is a terminal launched without the env var, or a Claude Code version below v2.1.187 (v2.1.208+ for multi-select checkboxes) — `/tui fullscreen` re-enables it for the current session.
