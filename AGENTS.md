# Everything Claude Code (ECC) — Agent Instructions

This is a **production-ready AI coding plugin** providing 71 specialized agents, 199 skills, 79 commands, and automated hook workflows for software development.

**Version:** 2.0.0-rc.1

## Core Principles

1. **Agent-First** — Delegate to specialized agents for domain tasks
2. **Test-Driven** — Write tests before implementation, 80%+ coverage required
3. **Security-First** — Never compromise on security; validate all inputs
4. **Immutability** — Always create new objects, never mutate existing ones
5. **Plan Before Execute** — Plan complex features before writing code

## Available Agents

71 agents in `~/.claude/agents/`. Claude Code also exposes built-ins not listed
here (`general-purpose`, `Explore`, `Plan`, `claude`, `claude-code-guide`,
`statusline-setup`).

### Planning & architecture

| Agent | When to use |
|-------|-------------|
| planner | Complex features, refactoring — break into phases |
| architect | System design, scalability, technical decisions |
| code-architect | Feature blueprints that follow existing codebase patterns |
| code-explorer | Trace execution paths and map layers before changing code |
| context-manager | Structure shared files/state for multi-agent workflows |
| homelab-architect | Home / small-lab network plans with staged rollback |
| network-architect | Enterprise or multi-site network architecture |

### Code quality & review (language-agnostic)

| Agent | When to use |
|-------|-------------|
| code-reviewer | After writing or modifying any code |
| security-reviewer | User input, auth, API endpoints, sensitive data |
| performance-optimizer | Bottlenecks, bundle size, memory, render cost |
| refactor-cleaner | Dead code, duplicates, consolidation |
| code-simplifier | Clarity and consistency pass, behavior preserved |
| comment-analyzer | Comment accuracy and comment-rot risk |
| silent-failure-hunter | Swallowed errors, bad fallbacks, missing propagation |
| type-design-analyzer | Encapsulation, invariants, type usefulness |
| pr-test-analyzer | PR test coverage quality and behavioral gaps |
| a11y-architect | WCAG 2.2 compliance, inclusive UI components |

### Language & framework reviewers

| Agent | When to use |
|-------|-------------|
| typescript-reviewer | TypeScript / JavaScript changes |
| react-reviewer | .tsx/.jsx, hooks, server/client boundaries |
| python-reviewer | Python changes |
| django-reviewer | Django apps, DRF, ORM, migrations |
| fastapi-reviewer | FastAPI async, DI, Pydantic, OpenAPI |
| go-reviewer | Go changes |
| rust-reviewer | Rust changes |
| java-reviewer | Java, Spring Boot, Quarkus |
| kotlin-reviewer | Kotlin, Android, KMP |
| swift-reviewer | Swift changes |
| cpp-reviewer | C / C++ changes |
| csharp-reviewer | C# / .NET changes |
| fsharp-reviewer | F# changes |
| flutter-reviewer | Flutter / Dart widgets and state |
| database-reviewer | PostgreSQL / Supabase schema and queries |
| mle-reviewer | ML pipelines, evals, serving, monitoring |
| healthcare-reviewer | Clinical safety, PHI, EMR/EHR code |
| harmonyos-app-resolver | HarmonyOS / ArkTS / ArkUI projects |
| network-config-reviewer | Router and switch configuration review |

### Build & error resolution

| Agent | When to use |
|-------|-------------|
| build-error-resolver | Generic build / TypeScript type failures |
| react-build-resolver | Vite, webpack, Next.js, CRA, Parcel, esbuild, Bun |
| go-build-resolver | Go build and vet failures |
| rust-build-resolver | cargo build, borrow checker, Cargo.toml |
| java-build-resolver | Maven / Gradle failures |
| kotlin-build-resolver | Kotlin / Gradle failures |
| swift-build-resolver | swift build, Xcode, SPM, code signing |
| cpp-build-resolver | CMake, linker, template errors |
| dart-build-resolver | dart analyze, Flutter build, pub, build_runner |
| django-build-resolver | pip/Poetry, migrations, collectstatic |
| pytorch-build-resolver | Tensor shapes, CUDA, gradients, DataLoader |

### Testing & documentation

| Agent | When to use |
|-------|-------------|
| tdd-guide | New features and bug fixes — tests first |
| e2e-runner | Critical user flows (Agent Browser / Playwright) |
| doc-updater | Codemaps, READMEs, guides |
| docs-lookup | Library / API docs via Context7 |

### Workflow harnesses

| Agent | When to use |
|-------|-------------|
| gan-planner | Expand a one-line prompt into a full product spec |
| gan-generator | Implement against the spec, iterate on feedback |
| gan-evaluator | Score the running app against the rubric |
| opensource-forker | Fork and strip secrets for open-sourcing |
| opensource-sanitizer | Verify a fork is clean before release |
| opensource-packager | Generate README, LICENSE, CONTRIBUTING, setup |

### Operations

| Agent | When to use |
|-------|-------------|
| loop-operator | Run autonomous loops, detect stalls, intervene |
| harness-optimizer | Harness config reliability, cost, throughput |
| conversation-analyzer | Mine transcripts for behaviors worth hooking |
| network-troubleshooter | Read-only OSI-layer connectivity diagnosis |

### Cost offload

| Agent | When to use |
|-------|-------------|
| cheap-worker | Bulk refactors and first drafts via OpenRouter (~1-2% cost) |
| free-worker | High-volume mechanical generation on a free model |

### Business & product

| Agent | When to use |
|-------|-------------|
| product-manager | Product strategy, prioritization, roadmap |
| market-researcher | Market sizing, consumer behavior, opportunity |
| competitive-analyst | Competitor benchmarking and positioning |
| marketing-agent | Campaign planning, positioning, copy |
| content-marketer | SEO content strategy and multi-channel campaigns |
| seo-specialist | Technical SEO audits, schema, Core Web Vitals |
| legal-advisor | Contracts, compliance, IP, risk assessment |
| chief-of-staff | Multi-channel message triage and draft replies |

## Agent Orchestration

Use agents proactively without user prompt:
- Complex feature requests → **planner**
- Code just written/modified → **code-reviewer**
- Bug fix or new feature → **tdd-guide**
- Architectural decision → **architect**
- Security-sensitive code → **security-reviewer**
- Autonomous loops / loop monitoring → **loop-operator**
- Harness config reliability and cost → **harness-optimizer**

Use parallel execution for independent operations — launch multiple agents simultaneously.

## Security Guidelines

**Before ANY commit:**
- No hardcoded secrets (API keys, passwords, tokens)
- All user inputs validated
- SQL injection prevention (parameterized queries)
- XSS prevention (sanitized HTML)
- CSRF protection enabled
- Authentication/authorization verified
- Rate limiting on all endpoints
- Error messages don't leak sensitive data

**Secret management:** NEVER hardcode secrets. Use environment variables or a secret manager. Validate required secrets at startup. Rotate any exposed secrets immediately.

**If security issue found:** STOP → use security-reviewer agent → fix CRITICAL issues → rotate exposed secrets → review codebase for similar issues.

## Coding Style

**Immutability (CRITICAL):** Always create new objects, never mutate. Return new copies with changes applied.

**File organization:** Many small files over few large ones. 200-400 lines typical, 800 max. Organize by feature/domain, not by type. High cohesion, low coupling.

**Error handling:** Handle errors at every level. Provide user-friendly messages in UI code. Log detailed context server-side. Never silently swallow errors.

**Input validation:** Validate all user input at system boundaries. Use schema-based validation. Fail fast with clear messages. Never trust external data.

**Code quality checklist:**
- Functions small (<50 lines), files focused (<800 lines)
- No deep nesting (>4 levels)
- Proper error handling, no hardcoded values
- Readable, well-named identifiers

## Testing Requirements

**Minimum coverage: 80%**

Test types (all required):
1. **Unit tests** — Individual functions, utilities, components
2. **Integration tests** — API endpoints, database operations
3. **E2E tests** — Critical user flows

**TDD workflow (mandatory):**
1. Write test first (RED) — test should FAIL
2. Write minimal implementation (GREEN) — test should PASS
3. Refactor (IMPROVE) — verify coverage 80%+

Troubleshoot failures: check test isolation → verify mocks → fix implementation (not tests, unless tests are wrong).

## Development Workflow

1. **Plan** — Use planner agent, identify dependencies and risks, break into phases
2. **TDD** — Use tdd-guide agent, write tests first, implement, refactor
3. **Review** — Use code-reviewer agent immediately, address CRITICAL/HIGH issues
4. **Capture knowledge in the right place**
   - Personal debugging notes, preferences, and temporary context → auto memory
   - Team/project knowledge (architecture decisions, API changes, runbooks) → the project's existing docs structure
   - If the current task already produces the relevant docs or code comments, do not duplicate the same information elsewhere
   - If there is no obvious project doc location, ask before creating a new top-level file
5. **Commit** — Conventional commits format, comprehensive PR summaries

## Workflow Surface Policy

- `skills/` is the canonical workflow surface.
- New workflow contributions should land in `skills/` first.
- `commands/` is a legacy slash-entry compatibility surface and should only be added or updated when a shim is still required for migration or cross-harness parity.

## Git Workflow

**Commit format:** `<type>: <description>` — Types: feat, fix, refactor, docs, test, chore, perf, ci

**PR workflow:** Analyze full commit history → draft comprehensive summary → include test plan → push with `-u` flag.

## Architecture Patterns

**API response format:** Consistent envelope with success indicator, data payload, error message, and pagination metadata.

**Repository pattern:** Encapsulate data access behind standard interface (findAll, findById, create, update, delete). Business logic depends on abstract interface, not storage mechanism.

**Skeleton projects:** Search for battle-tested templates, evaluate with parallel agents (security, extensibility, relevance), clone best match, iterate within proven structure.

## Performance

**Context management:** Avoid last 20% of context window for large refactoring and multi-file features. Lower-sensitivity tasks (single edits, docs, simple fixes) tolerate higher utilization.

**Build troubleshooting:** Use build-error-resolver agent → analyze errors → fix incrementally → verify after each fix.

## Project Structure

```
agents/          — 71 specialized subagents
skills/          — 199 workflow skills and domain knowledge
commands/        — 79 slash commands
hooks/           — Trigger-based automations
rules/           — Always-follow guidelines (common + per-language)
scripts/         — Cross-platform Node.js utilities
mcp-configs/     — 29 MCP server configurations
tests/           — Test suite
```

`commands/` remains in the repo for compatibility, but the long-term direction is skills-first.

## Success Metrics

- All tests pass with 80%+ coverage
- No security vulnerabilities
- Code is readable and maintainable
- Performance is acceptable
- User requirements are met
