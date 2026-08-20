---
name: prefers-verified-status-recaps
description: User wants short verified status recaps after completing a step, not just at the end of a task
metadata:
  type: feedback
---

After finishing a step, close with a short recap that states what is confirmed working, backed by concrete evidence (version numbers, resolved paths, registry/config state), then what is still pending. Asked for this on 2026-08-20 after an Antigravity CLI install recap and said to do it "more often".

**Why:** Terminal output is noisy and easy to misread — the Antigravity installer printed real success messages prefixed with `ERROR:` (glog writing to stderr), which looked like a failed install. A recap that separates verified facts from noise told them the actual state in one line instead of making them parse the scrollback.

**How to apply:** Lead with a bolded one-line verdict (e.g. "**Installed and working — `agy` v1.1.16**"). Follow with the evidence that proves it, not a vague "it works". Then name what is next and what is deliberately deferred, with the reason for deferring. Keep it to a few lines — this is a recap, not a report. Do it per-step on multi-step work, not only at the very end. Pair with [[verify-before-claiming-done]].
