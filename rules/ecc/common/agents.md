# Agent Orchestration

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

## Immediate Agent Usage

No user prompt needed:
1. Complex feature requests - Use **planner** agent
2. Code just written/modified - Use **code-reviewer** agent
3. Bug fix or new feature - Use **tdd-guide** agent
4. Architectural decision - Use **architect** agent

Prefer the language-specific reviewer over the generic **code-reviewer** when the
change is confined to one language, and run both when a change spans several.

## Parallel Task Execution

ALWAYS use parallel Task execution for independent operations:

```markdown
# GOOD: Parallel execution
Launch 3 agents in parallel:
1. Agent 1: Security analysis of auth module
2. Agent 2: Performance review of cache system
3. Agent 3: Type checking of utilities

# BAD: Sequential when unnecessary
First agent 1, then agent 2, then agent 3
```

## Multi-Perspective Analysis

For complex problems, use split role sub-agents:
- Factual reviewer
- Senior engineer
- Security expert
- Consistency reviewer
- Redundancy checker
