# Rules
## Structure

Rules are organized into a **common** layer plus **language-specific** directories:

```
rules/ecc/
├── common/          # Language-agnostic principles (always install)
│   ├── agents.md
│   ├── code-review.md
│   ├── coding-style.md
│   ├── development-workflow.md
│   ├── git-workflow.md
│   ├── hooks.md
│   ├── patterns.md
│   ├── performance.md
│   ├── security.md
│   └── testing.md
├── typescript/      # TypeScript/JavaScript specific
├── react/           # React specific
├── angular/         # Angular specific
├── python/          # Python specific
├── golang/          # Go specific
├── rust/            # Rust specific
├── java/            # Java specific
├── kotlin/          # Kotlin specific
├── csharp/          # C# / .NET specific
├── cpp/             # C / C++ specific
├── fsharp/          # F# specific
├── swift/           # Swift specific
├── dart/            # Dart / Flutter specific
├── php/             # PHP specific
├── perl/            # Perl specific
├── ruby/            # Ruby / Rails specific
├── web/             # Web and frontend specific
└── arkts/           # HarmonyOS / ArkTS specific
```

- **common/** contains universal principles — no language-specific code examples.
- **Language directories** extend the common rules with framework-specific patterns, tools, and code examples. Each file references its common counterpart.

## Installation

### Option 1: Install Script (Recommended)

> `install.sh` ships with the upstream ECC repo, not with this synced copy of
> `~/.claude`. If it is not present, use Option 2 below.

```bash
# Install common + one or more language-specific rule sets.
# Available sets: typescript, react, angular, python, golang, rust, java,
# kotlin, csharp, cpp, fsharp, swift, dart, php, perl, ruby, web, arkts
./install.sh typescript
./install.sh python
./install.sh rust

# Install multiple languages at once
./install.sh typescript react python
```

### Option 2: Manual Installation

> **Important:** Copy entire directories — do NOT flatten with `/*`.
> Common and language-specific directories contain files with the same names.
> Flattening them into one directory causes language-specific files to overwrite
> common rules, and breaks the relative `../common/` references used by
> language-specific files.
>
> Use the ECC-owned namespace below for user-level Claude installs. Flat
> package-level destinations can collide with non-ECC rule packs and do not
> match the main README guidance.

```bash
# Create the ECC rule namespace once.
mkdir -p ~/.claude/rules/ecc

# Install common rules (required for all projects)
cp -r rules/ecc/common ~/.claude/rules/ecc/

# Install language-specific rules based on your project's tech stack.
# Pick only the sets your project actually uses — these are examples.
cp -r rules/ecc/typescript ~/.claude/rules/ecc/
cp -r rules/ecc/react ~/.claude/rules/ecc/
cp -r rules/ecc/python ~/.claude/rules/ecc/
cp -r rules/ecc/golang ~/.claude/rules/ecc/
cp -r rules/ecc/rust ~/.claude/rules/ecc/
cp -r rules/ecc/web ~/.claude/rules/ecc/

# Attention ! ! ! Configure according to your actual project requirements; the configuration here is for reference only.
```

For project-local rules, use the same namespace under the project root:

```bash
mkdir -p .claude/rules/ecc
cp -r rules/ecc/common .claude/rules/ecc/
cp -r rules/ecc/typescript .claude/rules/ecc/
```

## Rules vs Skills

- **Rules** define standards, conventions, and checklists that apply broadly (e.g., "80% test coverage", "no hardcoded secrets").
- **Skills** (`skills/ecc/` directory) provide deep, actionable reference material for specific tasks (e.g., `python-patterns`, `golang-testing`).

Language-specific rule files reference relevant skills where appropriate. Rules tell you *what* to do; skills tell you *how* to do it.

## Adding a New Language

To add support for a new language (e.g., `zig/`):

1. Create a `rules/ecc/zig/` directory
2. Add files that extend the common rules:
   - `coding-style.md` — formatting tools, idioms, error handling patterns
   - `testing.md` — test framework, coverage tools, test organization
   - `patterns.md` — language-specific design patterns
   - `hooks.md` — PostToolUse hooks for formatters, linters, type checkers
   - `security.md` — secret management, security scanning tools
3. Each file should start with:
   ```
   > This file extends [common/xxx.md](../common/xxx.md) with <Language> specific content.
   ```
4. Reference existing skills if available, or create new ones under `skills/`.

For non-language domains like `web/`, follow the same layered pattern when there is enough reusable domain-specific guidance to justify a standalone ruleset.

## Rule Priority

When language-specific rules and common rules conflict, **language-specific rules take precedence** (specific overrides general). This follows the standard layered configuration pattern (similar to CSS specificity or `.gitignore` precedence).

- `rules/ecc/common/` defines universal defaults applicable to all projects.
- `rules/ecc/golang/`, `rules/ecc/python/`, `rules/ecc/rust/`, `rules/ecc/typescript/`, etc. override those defaults where language idioms differ.

### Example

`common/coding-style.md` recommends immutability as a default principle. A language-specific `golang/coding-style.md` can override this:

> Idiomatic Go uses pointer receivers for struct mutation — see [common/coding-style.md](../common/coding-style.md) for the general principle, but Go-idiomatic mutation is preferred here.

### Common rules with override notes

Rules in `rules/ecc/common/` that may be overridden by language-specific files are marked with:

> **Language note**: This rule may be overridden by language-specific rules for languages where this pattern is not idiomatic.
