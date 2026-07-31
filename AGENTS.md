# Everything Claude Code (ECC) — Agent Instructions

This is a **production-ready AI coding plugin** providing 65 specialized agents, 198 skills, 79 commands, and automated hook workflows for software development.

**Version:** 2.0.0-rc.1

## Core Principles

1. **Agent-First** — Delegate to specialized agents for domain tasks
2. **Test-Driven** — Write tests before implementation, 80%+ coverage required
3. **Security-First** — Never compromise on security; validate all inputs
4. **Immutability** — Always create new objects, never mutate existing ones
5. **Plan Before Execute** — Plan complex features before writing code

## Available Agents

All 65 agents live in `agents/`. Each file's frontmatter is the source of truth
for its trigger conditions; the tables below are a navigation index.

### Planning and architecture

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| planner | Implementation planning | Complex features, refactoring |
| architect | System design and scalability | Architectural decisions |
| code-architect | Feature blueprints from existing codebase patterns | Before implementing a feature in an established codebase |
| code-explorer | Traces execution paths and maps architecture layers | Understanding an unfamiliar feature before changing it |
| a11y-architect | WCAG 2.2 accessibility for web and native | Designing UI components, design systems, a11y audits |
| homelab-architect | Home/small-lab network plans | Staged network changes with rollback guidance |
| network-architect | Enterprise/multi-site network architecture | Network design from requirements |

### Code review and quality

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| code-reviewer | Code quality and maintainability | After writing/modifying code |
| security-reviewer | Vulnerability detection | Before commits, sensitive code |
| code-simplifier | Clarity and consistency without behavior change | Recently modified code |
| comment-analyzer | Comment accuracy and comment-rot risk | Doc-heavy or long-lived code |
| silent-failure-hunter | Swallowed errors, bad fallbacks, missing propagation | Error-handling review |
| type-design-analyzer | Encapsulation, invariants, enforcement | Type/API design review |
| pr-test-analyzer | PR test coverage quality and completeness | Reviewing a pull request |
| performance-optimizer | Bottlenecks, bundle size, runtime performance | Profiling, memory leaks, render optimization |
| refactor-cleaner | Dead code cleanup | Code maintenance |
| doc-updater | Documentation and codemaps | Updating docs |
| docs-lookup | Documentation lookup via Context7 | API/docs questions |

### Language and framework reviewers

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| typescript-reviewer | TypeScript/JavaScript code review | TypeScript/JavaScript projects |
| react-reviewer | Hooks, render perf, server/client boundaries | Any `.tsx`/`.jsx` change |
| python-reviewer | Python code review | Python projects |
| django-reviewer | Django code review | Django apps, DRF APIs, ORM, migrations |
| fastapi-reviewer | Async correctness, DI, Pydantic, OpenAPI | FastAPI applications |
| java-reviewer | Java and Spring Boot code review | Java/Spring Boot projects |
| kotlin-reviewer | Kotlin code review | Kotlin/Android/KMP projects |
| go-reviewer | Go code review | Go projects |
| rust-reviewer | Rust code review | Rust projects |
| swift-reviewer | Protocol-oriented design, ARC, Swift Concurrency | Swift projects |
| csharp-reviewer | .NET conventions, async, nullable reference types | C# projects |
| cpp-reviewer | C/C++ code review | C and C++ projects |
| fsharp-reviewer | F# functional code review | F# projects |
| flutter-reviewer | Widget patterns, state management, Dart idioms | Flutter projects |
| harmonyos-app-resolver | ArkTS/ArkUI review and fixes | HarmonyOS/OpenHarmony projects |
| database-reviewer | PostgreSQL/Supabase specialist | Schema design, query optimization |
| mle-reviewer | Production ML pipeline review | ML pipelines, evals, serving, monitoring, rollback |
| healthcare-reviewer | Clinical safety, CDSS accuracy, PHI compliance | EMR/EHR and health information systems |
| network-config-reviewer | Router/switch config security and correctness | Network config changes |

### Build and test

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| build-error-resolver | Fix build/type errors | When build fails |
| react-build-resolver | Vite/webpack/Next.js/CRA/Parcel/esbuild/Bun failures | React build failures |
| java-build-resolver | Java/Maven/Gradle build errors | Java build failures |
| kotlin-build-resolver | Kotlin/Gradle build errors | Kotlin build failures |
| go-build-resolver | Go build errors | Go build failures |
| rust-build-resolver | Rust build errors | Rust build failures |
| swift-build-resolver | Swift/Xcode/SPM/code signing errors | Swift build failures |
| dart-build-resolver | `dart analyze`, pub, build_runner errors | Dart/Flutter build failures |
| cpp-build-resolver | C/C++ build errors | C and C++ build failures |
| django-build-resolver | Django startup, dependency, migration, collectstatic failures | Django build failures |
| pytorch-build-resolver | PyTorch runtime/CUDA/training errors | PyTorch build/training failures |
| tdd-guide | Test-driven development | New features, bug fixes |
| e2e-runner | End-to-end Playwright testing | Critical user flows |

### Operations and orchestration

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| loop-operator | Autonomous loop execution | Run loops safely, monitor stalls, intervene |
| harness-optimizer | Harness config tuning | Reliability, cost, throughput |
| conversation-analyzer | Find behaviors worth preventing with hooks | `/hookify` without arguments |
| network-troubleshooter | Read-only OSI-layer diagnosis | Connectivity, routing, DNS, policy symptoms |
| chief-of-staff | Multi-channel comms triage and draft replies | Email/Slack/LINE/Messenger workflows |
| free-worker | Bulk mechanical work on a free OpenRouter model | High-volume work where quality matters less than cost |
| cheap-worker | Substantive non-critical work at ~1-2% of Claude cost | Bulk refactors, first drafts, test scaffolding |

### GAN harness (iterative build/evaluate loop)

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| gan-planner | Expands a one-line prompt into a full spec | Start of a GAN run |
| gan-generator | Implements against the spec, iterates on feedback | GAN build phase |
| gan-evaluator | Tests the live app via Playwright, scores vs rubric | GAN evaluation phase |

### Open-source pipeline

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| opensource-forker | Fork, strip secrets, replace internal references | Stage 1 of `opensource-pipeline` |
| opensource-sanitizer | Verify sanitization, PASS/FAIL report | Stage 2 — before any public release |
| opensource-packager | Generate CLAUDE.md, README, LICENSE, templates | Stage 3 of `opensource-pipeline` |

### Growth

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| marketing-agent | Campaign planning, positioning, copy | Product launches and marketing campaigns |
| seo-specialist | Technical SEO, structured data, Core Web Vitals | Site audits and SEO remediation |

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
agents/          — 65 specialized subagents
skills/          — 198 workflow skills and domain knowledge (ecc/ + pmo-artifact/)
commands/        — 79 slash commands
hooks/           — Trigger-based automations
rules/           — Always-follow guidelines (common + per-language, under rules/ecc/)
scripts/         — Cross-platform Node.js utilities and hook implementations
mcp-configs/     — MCP server configurations (29 servers in mcp-servers.json)
```

`commands/` remains in the repo for compatibility, but the long-term direction is skills-first.

## Success Metrics

- All tests pass with 80%+ coverage
- No security vulnerabilities
- Code is readable and maintainable
- Performance is acceptable
- User requirements are met
