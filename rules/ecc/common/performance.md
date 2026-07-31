# Performance Optimization

## Model Selection Strategy

Current generation is the **Claude 5 family**. Use these model IDs in agent
frontmatter (`model:`) and CLI flags:

| Tier | Model ID | Use for |
|------|----------|---------|
| Haiku | `claude-haiku-4-5-20251001` | Lightweight agents invoked frequently, worker agents in multi-agent systems, high-volume simple tasks |
| Sonnet | `claude-sonnet-5` | Main development work, orchestrating multi-agent workflows, most coding tasks |
| Opus | `claude-opus-5` | Complex architectural decisions, deepest reasoning, research and analysis. 1M context window |

`claude-fable-5` also exists in the Claude 5 family; check current docs before
assigning it to an agent.

Cost scales with capability — default to the cheapest tier that reliably does
the job, and reserve Opus for work that genuinely needs the reasoning depth or
the larger context window.

When building AI applications, default to the latest and most capable Claude
models rather than pinning old versions.

### Fast Mode

Fast mode trades cost for lower latency using Claude Opus with faster output —
it does **not** downgrade to a smaller model.

- Toggle with `/fast`
- Available on Opus 5, 4.8, and 4.7
- Useful for interactive iteration where wall-clock latency dominates

## Context Window Management

Avoid last 20% of context window for:
- Large-scale refactoring
- Feature implementation spanning multiple files
- Debugging complex interactions

Lower context sensitivity tasks:
- Single-file edits
- Independent utility creation
- Documentation updates
- Simple bug fixes

## Extended Thinking + Plan Mode

Extended thinking is enabled by default, reserving up to 31,999 tokens for internal reasoning.

Control extended thinking via:
- **Toggle**: Option+T (macOS) / Alt+T (Windows/Linux)
- **Config**: Set `alwaysThinkingEnabled` in `~/.claude/settings.json`
- **Budget cap**: `export MAX_THINKING_TOKENS=10000`
- **Verbose mode**: Ctrl+O to see thinking output

For complex tasks requiring deep reasoning:
1. Ensure extended thinking is enabled (on by default)
2. Enable **Plan Mode** for structured approach
3. Use multiple critique rounds for thorough analysis
4. Use split role sub-agents for diverse perspectives

## Build Troubleshooting

If build fails:
1. Use **build-error-resolver** agent
2. Analyze error messages
3. Fix incrementally
4. Verify after each fix
