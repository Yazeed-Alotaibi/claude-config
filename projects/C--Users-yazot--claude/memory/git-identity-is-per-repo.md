---
name: git-identity-is-per-repo
description: This machine has no global git user.name/email — set them per-repo after every fresh clone or commits will fail
metadata: 
  node_type: memory
  type: project
  originSessionId: 2530eec8-6709-4868-ad5c-f5edd8f10cef
  modified: 2026-08-06T05:17:10.732Z
---

There is no global git identity on this machine. `git config --global user.name`
and `user.email` both return nothing; `~/.gitconfig` holds only
`[windows] appendAtomically = false`. Existing repos like `~/.claude` carry the
identity in their own `.git/config` instead.

After any fresh clone, set it before committing:

```bash
git config user.name "Yazeed"
git config user.email "yaz.otb.sa@gmail.com"
```

Git Credential Manager *is* installed
(`/c/Program Files/Git/mingw64/bin/git-credential-manager.exe`), so pushes to
GitHub authenticate without extra setup even though `credential.helper` is unset
globally.

**Why:** hit on 2026-08-06 cloning `yazeed-blog` — `git config user.name` exited
1, and a commit would have failed or been misattributed.

**How to apply:** run the two config lines immediately after cloning, before the
first commit. Don't set them globally unless asked; the per-repo pattern looks
deliberate.
