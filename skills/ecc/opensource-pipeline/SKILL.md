---
name: opensource-pipeline
description: Take a private project to a publishable open-source repo in three gated stages — fork and strip secrets, verify sanitization, then generate packaging. Use before publishing any internal project publicly.
origin: ECC
---

# Open Source Pipeline

Orchestrates the three `opensource-*` agents in order, with a hard safety gate between
stage 2 and stage 3. Each agent already defines its own stage; this skill sequences them
and enforces the gate.

## Usage

```
/opensource-pipeline <path-to-project> [--target <staging-dir>] [--license MIT|Apache-2.0|...]
```

If no target is given, stage the fork at `<project>-oss` as a sibling directory.

## Non-negotiable rules

- **Never modify the source project.** Every write happens in the staging directory.
  The original repo is read-only for the entire pipeline.
- **Stage 2 is a gate, not a report.** A FAIL means stop. Do not proceed to packaging,
  do not `git init`, do not create a remote, do not push.
- **Never create a public remote as part of this pipeline.** Publishing is the user's
  action, taken after they have read the reports. This skill prepares a directory; it
  does not release it.
- If the user asks to skip stage 2, refuse and explain why. The gate is the only thing
  standing between a private credential and a public repo.

## Stage 1 — Fork (`opensource-forker`)

Launch the `opensource-forker` agent with the source path and staging target.

Produces:
- A staged copy of the project, excluding secrets and generated files
- `.env.example` derived from every extracted value
- `FORK_REPORT.md` documenting every change made

Before continuing, read `FORK_REPORT.md` and confirm the staging directory exists and is
non-empty. If the forker reports files it could not classify, surface those to the user
now rather than after the scan.

## Stage 2 — Verify (`opensource-sanitizer`) — GATE

Launch the `opensource-sanitizer` agent against the **staging directory**, never the source.

This agent is read-only by design; it reports and does not fix. It returns one of:

| Verdict | Meaning | Action |
|---|---|---|
| `PASS` | No secrets, PII, or internal references found | Proceed to stage 3 |
| `PASS-WITH-WARNINGS` | Nothing disqualifying, but items need a human look | Show every warning, ask the user to confirm before stage 3 |
| `FAIL` | Secrets, PII, or dangerous files present | **Stop.** Report findings. Do not proceed |

On `FAIL`: report exactly what was found and where. The fix path is to re-run stage 1
with the gaps addressed, then re-scan — not to hand-patch the staging directory and
assume it is clean. Re-run the gate after any fix.

Do not summarize a `FAIL` as "mostly clean". State the verdict plainly.

## Stage 3 — Package (`opensource-packager`)

Only reachable after `PASS`, or `PASS-WITH-WARNINGS` the user has explicitly accepted.

Launch the `opensource-packager` agent against the verified staging directory.

Produces:
- `CLAUDE.md` — project context for Claude Code
- `setup.sh` — one-command bootstrap
- `README.md`, `LICENSE`, `CONTRIBUTING.md`
- GitHub issue templates

Pass the user's license choice through. If none was given, ask — do not default silently,
since the license determines how others may use the work.

## Final report

```
OPENSOURCE PIPELINE

Source:     <path>          (unmodified)
Staged at:  <staging-dir>

Stage 1 Fork:      <files copied, secrets stripped, see FORK_REPORT.md>
Stage 2 Verify:    PASS | PASS-WITH-WARNINGS | FAIL
Stage 3 Package:   <files generated>  |  SKIPPED (gate not passed)

Warnings accepted by user: <list, or none>

Ready to publish: YES | NO — <reason>
```

Close by telling the user the staging directory is prepared but **not published**, and
that creating the remote and pushing is their call.

## Notes

- The three agents are independent and can be run alone. This skill exists because the
  ordering and the gate matter — running the packager on an unverified fork is how a
  credential reaches a public repo.
- `opensource-sanitizer` is marked "use PROACTIVELY before any public release." That
  applies outside this pipeline too: run it against any repo about to go public, even
  one this pipeline never touched.
- Related: [[security-reviewer]] for code-level vulnerabilities, which this pipeline
  does not assess — it checks for leaked material, not insecure logic.
