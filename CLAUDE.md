<!-- rtk-instructions v2 -->
# RTK (Rust Token Killer) - Token-Optimized Commands

## Golden Rule

**Always prefix commands with `rtk`**. If RTK has a dedicated filter, it uses it. If not, it passes through unchanged. This means RTK is always safe to use.

**Important**: Even in command chains with `&&`, use `rtk`:
```bash
# ❌ Wrong
git add . && git commit -m "msg" && git push

# ✅ Correct
rtk git add . && rtk git commit -m "msg" && rtk git push
```

## RTK Commands by Workflow

### Build & Compile (80-90% savings)
```bash
rtk cargo build         # Cargo build output
rtk cargo check         # Cargo check output
rtk cargo clippy        # Clippy warnings grouped by file (80%)
rtk tsc                 # TypeScript errors grouped by file/code (83%)
rtk lint                # ESLint/Biome violations grouped (84%)
rtk prettier --check    # Files needing format only (70%)
rtk next build          # Next.js build with route metrics (87%)
```

### Test (90-99% savings)
```bash
rtk cargo test          # Cargo test failures only (90%)
rtk vitest run          # Vitest failures only (99.5%)
rtk playwright test     # Playwright failures only (94%)
rtk test <cmd>          # Generic test wrapper - failures only
```

### Git (59-80% savings)
```bash
rtk git status          # Compact status
rtk git log             # Compact log (works with all git flags)
rtk git diff            # Compact diff (80%)
rtk git show            # Compact show (80%)
rtk git add             # Ultra-compact confirmations (59%)
rtk git commit          # Ultra-compact confirmations (59%)
rtk git push            # Ultra-compact confirmations
rtk git pull            # Ultra-compact confirmations
rtk git branch          # Compact branch list
rtk git fetch           # Compact fetch
rtk git stash           # Compact stash
rtk git worktree        # Compact worktree
```

Note: Git passthrough works for ALL subcommands, even those not explicitly listed.

### GitHub (26-87% savings)
```bash
rtk gh pr view <num>    # Compact PR view (87%)
rtk gh pr checks        # Compact PR checks (79%)
rtk gh run list         # Compact workflow runs (82%)
rtk gh issue list       # Compact issue list (80%)
rtk gh api              # Compact API responses (26%)
```

### JavaScript/TypeScript Tooling (70-90% savings)
```bash
rtk pnpm list           # Compact dependency tree (70%)
rtk pnpm outdated       # Compact outdated packages (80%)
rtk pnpm install        # Compact install output (90%)
rtk npm run <script>    # Compact npm script output
rtk npx <cmd>           # Compact npx command output
rtk prisma              # Prisma without ASCII art (88%)
```

### Files & Search (60-75% savings)
```bash
rtk ls <path>           # Tree format, compact (65%)
rtk read <file>         # Code reading with filtering (60%)
rtk grep <pattern>      # Search grouped by file (75%)
rtk find <pattern>      # Find grouped by directory (70%)
```

### Analysis & Debug (70-90% savings)
```bash
rtk err <cmd>           # Filter errors only from any command
rtk log <file>          # Deduplicated logs with counts
rtk json <file>         # JSON structure without values
rtk deps                # Dependency overview
rtk env                 # Environment variables compact
rtk summary <cmd>       # Smart summary of command output
rtk diff                # Ultra-compact diffs
```

### Infrastructure (85% savings)
```bash
rtk docker ps           # Compact container list
rtk docker images       # Compact image list
rtk docker logs <c>     # Deduplicated logs
rtk kubectl get         # Compact resource list
rtk kubectl logs        # Deduplicated pod logs
```

### Network (65-70% savings)
```bash
rtk curl <url>          # Compact HTTP responses (70%)
rtk wget <url>          # Compact download output (65%)
```

### Meta Commands
```bash
rtk gain                # View token savings statistics
rtk gain --history      # View command history with savings
rtk discover            # Analyze Claude Code sessions for missed RTK usage
rtk proxy <cmd>         # Run command without filtering (for debugging)
rtk init                # Add RTK instructions to CLAUDE.md
rtk init --global       # Add RTK to ~/.claude/CLAUDE.md
```

## Token Savings Overview

| Category | Commands | Typical Savings |
|----------|----------|-----------------|
| Tests | vitest, playwright, cargo test | 90-99% |
| Build | next, tsc, lint, prettier | 70-87% |
| Git | status, log, diff, add, commit | 59-80% |
| GitHub | gh pr, gh run, gh issue | 26-87% |
| Package Managers | pnpm, npm, npx | 70-90% |
| Files | ls, read, grep, find | 60-75% |
| Infrastructure | docker, kubectl | 85% |
| Network | curl, wget | 65-70% |

Overall average: **60-90% token reduction** on common development operations.
<!-- /rtk-instructions -->

# Claude Config Sync (~/.claude git repo)

`~/.claude` is a git repo synced across devices via `https://github.com/Yazeed-Alotaibi/claude-config.git`.

When the user types exactly **"claude pull"** in chat (any session, any project), run in `~/.claude`:
```bash
git pull
```
Report what changed (files touched, or "already up to date").

When the user types exactly **"claude push"** in chat, run in `~/.claude`:
```bash
git add -A
git commit -m "update: <short description of what changed>"
git push
```
If there's nothing to commit, just say so — don't push an empty commit.

Never run these two commands for any other repo unless the user is explicitly working inside `~/.claude`.

# Tool, Plugin, and Agent-Team Usage

I have installed a large set of MCP servers, plugins, skills, and agents deliberately. Use them — do not fall back to generic reasoning when a purpose-built tool exists.

## Reach for installed capability first

- **Before answering from memory about a library, framework, or API**, query Context7. My training data may be stale; the docs are one call away.
- **Before a broad web claim**, use Exa/Tavily search rather than asserting from memory.
- **For browser work** (verifying UI, reading console errors, checking network requests), drive Chrome DevTools MCP or claude-in-chrome instead of reasoning about what the page probably does.
- **For Office documents** (.docx/.xlsx/.pptx), use `officecli` rather than hand-rolling XML or python-docx.
- **For file/content search at scale**, prefer serena's symbol tools and the Explore agent over ad-hoc greps.
- When a connected MCP server plausibly covers a request (Supabase, Notion, Figma, Gmail, GitHub, n8n, …), search for its tools with ToolSearch before saying a capability is unavailable.

## Use skills as workflows, not decoration

Check for an applicable skill before starting substantive work, and follow it as written rather than skimming it for ideas. Process skills set the approach; implementation skills carry it out.

When several installed skills claim the same trigger, prefer in this order unless I say otherwise:
1. A skill I name explicitly
2. `superpowers:*` (process discipline — brainstorming, systematic-debugging, TDD, verification)
3. `ecc:*` (language- and stack-specific reviews and builds)
4. Standalone skills (addyosmani set, mattpocock set)

## Delegate to agents and agent teams

Agent teams are enabled (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`). Use them rather than doing everything in the main thread:

- **Independent work → parallel agents in one message.** Two or more tasks with no shared state should not run sequentially.
- **Multi-file features** → `agent-teams:team-feature` or `team-spawn` with file-ownership boundaries.
- **Code review** → `agent-teams:team-review` for multi-dimension review, or the matching `ecc:*-reviewer` for single-language changes.
- **Hard bugs with competing theories** → `agent-teams:team-debug`.
- **Broad searches where I only need the conclusion** → `Explore` agent, not a file dump into my context.
- **High-volume mechanical work** → `cheap-worker` or `free-worker` to keep cost down.

Delegate by default when work is parallelizable or when reading many files would bloat context. Report the agents' conclusions, not their transcripts.

## Standing exception

Workflows and multi-agent orchestration via the Workflow tool still require my explicit opt-in ("ultracode", "use a workflow"). This section does not grant that — it covers ordinary tools, skills, and the Agent tool.

# Response Style — Give Me Recaps

Applies to every project and every session.

Default to recapping. After any multi-step piece of work, close with a short summary covering:

- **What I asked for** — restated in your words, so I can catch a misread early
- **What you actually did** — the real actions taken, including anything that failed or was skipped
- **Where things stand now** — file paths, branches, PR links, current state
- **What's next** — the next command or decision, if one exists

On follow-up turns, open by restating the relevant prior context before building on it. Don't assume I still have the earlier turn in my head — I often run sessions in the background and read them after the fact, without the live tool output in front of me.

## Scope

This governs **your prose to me**, not tool output. It is not a reason to stop using RTK filters, to dump raw command output, or to paste agent transcripts. Compress the machine output as aggressively as ever; the recap is your own self-contained summary layered on top.

Keep recaps proportional — a few lines for small work, more for a long session. A recap that restates everything is as useless as none at all. Skip it entirely for greetings, one-line factual answers, and clarifying questions.

# Don't Ask Me For Approvals

Applies to every project and every session. I said "go YOLO" and I meant it.

Act on my stated intent instead of stopping to confirm. Specifically:

- **Don't ask permission to proceed** on work I already asked for. If I said do it, do it.
- **Don't present options and wait.** Pick the best one, state which you picked and why, and keep going.
- **Don't pause at intermediate checkpoints** to check I'm still happy. Finish the task, then report.
- **Make routine judgment calls yourself** — naming, structure, ordering, which tool, whether to clean up a redundant file. Note the call in the recap; don't front-load it as a question.
- **Ambiguity is not a blocker.** Choose the most reasonable reading, say which reading you chose, and deliver. I'll correct you after if it's wrong — that's cheaper than a round trip.

## The narrow exception

Still stop for genuinely irreversible destruction with no undo: force-push, history rewrite, `reset --hard` over uncommitted work, mass deletion outside the repo, dropping a production database, or anything that publishes to a third party under my name that I did not ask for. "Irreversible" is the bar — not "significant", not "I'd feel better checking". If git can undo it or the file is reconstructable, just do it.

This does not waive the Workflow-tool opt-in above ("ultracode" / "use a workflow"), which is about cost, not permission.
