# Performance Optimization

## Model Selection Strategy

Current generation is the **Claude 5 family**. Use these model IDs in agent
frontmatter (`model:`) and CLI flags:

| Tier | Model ID | Use for |
|------|----------|---------|
| Haiku | `claude-haiku-4-5-20251001` | Lightweight agents invoked frequently, worker agents in multi-agent systems, high-volume simple tasks |
| Sonnet | `claude-sonnet-5` | Main development work, orchestrating multi-agent workflows, most coding tasks |
| Opus | `claude-opus-5` | Complex architectural decisions, deepest reasoning, research and analysis. 1M context window |

**Fable 5** (`claude-fable-5`) is the most capable model in Claude Code, suited
to tasks larger than a single sitting — long autonomous sessions, root-cause
investigations, outage debugging, architecture decisions. It is **not** the
default; select it with `/model fable`. When using it:

- Describe the outcome, not the steps — let it plan the path
- Hand it ambiguous problems; the extra investigation pays off there
- Skip verification reminders — it verifies its own work with less prompting
- Size up: give it work you would normally break into pieces

Cost scales with capability — default to the cheapest tier that reliably does
the job, and reserve Opus/Fable for work that genuinely needs the reasoning
depth or the larger context window.

### Aliases vs pinned IDs

Prefer aliases in agent frontmatter so they track recommended versions; pin
full IDs only when you need a specific version.

| Alias | Resolves to (Anthropic API) |
|-------|------------------------------|
| `haiku` | Latest Haiku — simple tasks |
| `sonnet` | Sonnet 5 — daily coding |
| `opus` | Opus 5 — complex reasoning |
| `fable` | Fable 5 — hardest, longest-running tasks |
| `best` | Fable 5 where available, else latest Opus |
| `opusplan` | Opus during plan mode, then Sonnet for execution |
| `default` | Clears any override; reverts to account/org default |

Alias resolution differs on Bedrock, Google Cloud, and Microsoft Foundry — check
`/docs/en/model-config` if you are not on the Anthropic API.

When building AI applications, default to the latest and most capable Claude
models rather than pinning old versions.

### Fast Mode

Fast mode trades cost for lower latency using Claude Opus with faster output —
it does **not** downgrade to a smaller model.

- Toggle with `/fast`
- Available on Opus 5, 4.8, and 4.7
- Useful for interactive iteration where wall-clock latency dominates

## Context Window Management

Fable 5, Sonnet 5, Opus 4.6+, and Sonnet 4.6 support a **1M token context
window**. On the Anthropic API, Fable 5, Sonnet 5, and Opus 4.7+ always run with
it. On Max/Team/Enterprise plans Opus is auto-upgraded to 1M; Sonnet 4.6 with 1M
requires usage credits on every plan. Disable entirely with
`CLAUDE_CODE_DISABLE_1M_CONTEXT=1`. No pricing premium beyond 200K tokens.

Avoid last 20% of context window for:
- Large-scale refactoring
- Feature implementation spanning multiple files
- Debugging complex interactions

Lower context sensitivity tasks:
- Single-file edits
- Independent utility creation
- Documentation updates
- Simple bug fixes

## Effort Levels (primary reasoning control)

On models with adaptive reasoning, **effort level is the main lever** — not a
thinking token budget. The model decides whether and how much to think per step
based on task complexity.

| Level | When to use it |
|-------|----------------|
| `low` | Short, scoped, latency-sensitive tasks that are not intelligence-sensitive |
| `medium` | Cost-sensitive work that can trade off some intelligence |
| `high` | Balanced. **The default** on every model except Opus 4.7 |
| `xhigh` | Deeper reasoning at higher token spend. Default on Opus 4.7 |
| `max` | Deepest reasoning. Current session only (unless set via env var) |

Fable 5, Opus 5, Sonnet 5, Opus 4.8, and Opus 4.7 support all five levels.
Opus 4.6 and Sonnet 4.6 support `low`, `medium`, `high`, `max`. Setting an
unsupported level falls back to the highest supported level at or below it.

Set it with:
- `/effort <level>` in an interactive session (persists, except `max`)
- `claude --effort <level>` at launch
- `CLAUDE_CODE_EFFORT_LEVEL` env var, or `effortLevel` in settings

**`ultracode`** is a Claude Code setting rather than a model effort level: it
sends `xhigh` *and* has Claude orchestrate dynamic workflows for substantive
tasks. Session-only. Enable with `/effort ultracode` or `claude --effort ultracode`.

## Extended Thinking + Plan Mode

Extended thinking is the reasoning Claude emits before responding. On
adaptive-reasoning models the effort level above governs how much thinking
happens; these controls just turn it on/off and change how it displays.

| Control | How |
|---------|-----|
| Toggle for current session | `Option+T` (macOS) / `Alt+T` (Windows/Linux) |
| Global default | `/config` → thinking mode, saved as `alwaysThinkingEnabled` |
| Disable regardless of effort | `MAX_THINKING_TOKENS=0` in `env` |
| Show reasoning inline | `Ctrl+O` for verbose mode |
| Full summaries, not redacted | `showThinkingSummaries: true` in settings |

Notes:
- **Thinking cannot be turned off on Fable 5** — the toggle, `alwaysThinkingEnabled`,
  and `MAX_THINKING_TOKENS=0` all have no effect there
- You are charged for all thinking tokens, even when collapsed or redacted
- `MAX_THINKING_TOKENS` values other than `0` apply only with a fixed thinking
  budget, not with adaptive reasoning

For complex tasks requiring deep reasoning:
1. Raise the effort level rather than hand-tuning token budgets
2. Enable **Plan Mode** for a structured approach
3. Use multiple critique rounds for thorough analysis
4. Use split role sub-agents for diverse perspectives

## Build Troubleshooting

If build fails:
1. Use **build-error-resolver** agent
2. Analyze error messages
3. Fix incrementally
4. Verify after each fix
