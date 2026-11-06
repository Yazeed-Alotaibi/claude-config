# Trusted Websites: MCPs, Agent Evals, Android Apps, AI Models

*Researched 6 Nov 2026 with Tavily web research/search and OpenRouter's live benchmark feed. Counts and dates come from the sites or press at that time and change fast. Claims marked ⚠️ came from a single source and were not confirmed.*

---

## TL;DR: bookmark these first

| Topic | Start here | Then |
|---|---|---|
| **MCP servers** | registry.modelcontextprotocol.io | glama.ai/mcp (safety scores) |
| **Agent evals** | hal.cs.princeton.edu | swebench.com · tbench / snorkel.ai Terminal-Bench · arena.ai |
| **Android apps (off Play Store)** | f-droid.org + IzzyOnDroid repo | apkmirror.com (for Play apps) · GitHub releases via Obtainium |
| **AI models** | openrouter.ai/rankings + /compare | artificialanalysis.ai |

---

## 1. MCP server directories

| # | Site | What it is | Size (approx.) | Trust |
|---|---|---|---|---|
| 1 | **Official MCP Registry** — registry.modelcontextprotocol.io | The canonical "source of record," run by the MCP project. Searchable; links to npm/PyPI/repos. | Tens of thousands of entries ⚠️ | **Official.** Validates metadata only. **No security audit.** |
| 2 | **GitHub MCP Registry** — github.com/modelcontextprotocol/registry (+ GitHub's MCP listing) | Registry code and spec, plus GitHub's install-in-VS-Code buttons | Large | Official spec, open source. No security scoring. |
| 3 | **Glama** — glama.ai/mcp | Marketplace with safety and quality scores, maintainer verification, and an inspector sandbox | 20k+ servers ⚠️ | **Best trust signals** among the community sites |
| 4 | **PulseMCP** — pulsemcp.com | Curated view synced with the official registry; adds popularity and "official" flags | Large | Community, curated |
| 5 | **Smithery** — smithery.ai | Popular discovery catalog | 20k+ ⚠️ | Community. Little vetting; verify elsewhere. ⚠️ One source says its hosting/CLI features were retired in Oct 2026. |
| 6 | **mcp.so** | Big, multilingual community index with a playground | 17k+ ⚠️ | Unvetted. Use it for discovery only. |

**Beginner rule:** find a server anywhere, then confirm it on the **official registry** and check its **Glama score** and GitHub repo (stars, recent commits, a real maintainer) before installing.

---

## 2. Agent evaluation leaderboards and test results

| # | Site | Measures | Reliability notes |
|---|---|---|---|
| 1 | **HAL: Holistic Agent Leaderboard** — hal.cs.princeton.edu | Aggregates many agent benchmarks (SWE-bench Verified, τ-bench, AppWorld, CORE-bench…) with **cost and reliability** | Run by Princeton; open harness, independently run. ⚠️ Updates reportedly slowed in 2026. |
| 2 | **SWE-bench** — swebench.com | Fixing real GitHub issues (do the tests pass?) | Open and reproducible, but many scores are **self-reported** by labs. Nearing its ceiling. |
| 3 | **Terminal-Bench** — snorkel.ai/leaderboard/terminal-bench · vals.ai | Real command-line tasks | Docker harness is reproducible; task set is small |
| 4 | **τ-bench / τ³-bench** — Sierra Research (github) | Customer-service agents; **pass^k** = success across repeated tries | Good reliability metric; version confusion (τ → τ³) |
| 5 | **LMArena / Arena** — arena.ai (incl. Agent Arena) | Human votes in head-to-head comparisons | Live and huge, but votes can be biased or gamed; for-profit operator |
| 6 | **METR** — metr.org | "Time horizon": how long a task an agent can do alone | Independent nonprofit; software-engineering tasks only |
| 7 | **GAIA** — Hugging Face leaderboard | General assistant tasks (web, files, tools) | Near ceiling; some contamination risk |
| 8 | **BFCL (Berkeley Function Calling)** — gorilla.cs.berkeley.edu | Tool/function-calling accuracy | Academic and open; narrow scope |
| 9 | **Scale SEAL** — scale.com/leaderboard | Expert-built **private** test sets (incl. MCP Atlas) | Hard to game, but **not reproducible** by outsiders |
| 10 | **Epoch AI** — epoch.ai/benchmarks | Benchmark hub and trends | Respected research org; some evals internal |

**Beginner rule:** trust **independently run** results (HAL, METR, SEAL, Artificial Analysis) over **self-reported** numbers in lab blog posts. Look at **cost and reliability** too, not just accuracy.

---

## 3. Android apps outside the Play Store

### ⚠️ Big change to know: Google developer verification
- Google will require every app installed on **certified Android devices**, *including sideloaded ones*, to come from a developer who has registered with Google: government ID, a **$25 fee**, and their signing key.
- **Timeline (sources disagree):** first enforcement was announced for **Sept 2026 in Brazil, Indonesia, Singapore and Thailand**, with a global rollout through 2027. Android Authority reports the date **slid to 2027**. Check the current status before relying on either.
- An "advanced" path for unverified apps reportedly needs **developer options plus a 24-hour wait**.
- **F-Droid calls this an existential threat**, because it re-signs and builds apps itself. Many F-Droid apps may stop installing on mainstream phones unless their developers register.

### Ranked sources

| # | Source | Best for | How apps are verified | Reputation |
|---|---|---|---|---|
| 1 | **F-Droid** — f-droid.org | Free and open-source apps (~2,500+) | Built **from public source code** by F-Droid; many **reproducible builds**; lists "anti-features" (ads, tracking) | Highly trusted; most affected by Google's change |
| 2 | **IzzyOnDroid repo** — apt.izzysoft.de/fdroid (add it inside F-Droid / Droid-ify) | Open-source apps with **faster updates** | Uses the developer's own APKs; scanned and reviewed | Trusted by privacy communities |
| 3 | **Obtainium** (app) — github.com/ImranR98/Obtainium | Installing and **auto-updating straight from the developer's GitHub releases** | You get the developer's own signed file | Trusted; only as safe as the source you add |
| 4 | **APKMirror** — apkmirror.com | Play Store apps: older versions, early updates, region-locked apps | **Staff check every upload; signatures matched to the real developer**; no mods or piracy | **Best reputation** of the APK sites |
| 5 | **Aurora Store** (on F-Droid) | Downloading Play Store apps **without a Google account** | Files come from Google Play itself | Trusted; it's a middleman client |
| 6 | **Uptodown** — uptodown.com | Big catalog | Virus scans plus signature matching | Fairly reliable |
| 7 | **Samsung Galaxy Store / Huawei AppGallery / Amazon Appstore** | Brand-specific apps | Official vendor review | Official but limited |
| 8 | **APKPure** — apkpure.com | Big catalog | Signature matching (says VirusTotal scans) | **Caution:** its own app shipped a trojan in 2021 (Kaspersky), with further reports later. Use it only if nothing else has the app. |

### Safe sideloading tips
1. **Prefer the developer's own source** (official site, GitHub releases), then F-Droid/IzzyOnDroid, then APKMirror.
2. **Never install "modded," "cracked" or "premium unlocked" APKs.** They're the #1 malware route.
3. Keep **Play Protect on** and give "install unknown apps" permission **only to the one installer you use**, then turn it off.
4. Check the permissions: a flashlight app doesn't need your SMS or contacts.
5. Use one store per app, because updates must have the **same signature**. Mixing sources causes update failures.

---

## 4. AI model comparison sites

| # | Site | What it gives you | Reliability |
|---|---|---|---|
| 1 | **OpenRouter** — openrouter.ai/rankings · /compare · /models | **Real usage** rankings (what people actually use), live **prices**, context length, providers, uptime. You can also call models through one API. | Live data from real traffic. Popularity ≠ quality, so combine it with benchmarks. |
| 2 | **Artificial Analysis** — artificialanalysis.ai | **Independent** tests of intelligence, coding and agentic indexes, plus speed, latency and price; open-weights page | Runs its own tests; widely cited. A fixed test set can miss niche skills. |
| 3 | **LMArena / Arena** — arena.ai | Human-preference Elo (text, code, vision, search) | Huge vote volume; style and voting bias |
| 4 | **Hugging Face** — huggingface.co/models (+ leaderboards) | **Open-weight** models to download; license info | Essential for open models; check licenses carefully |
| 5 | **Epoch AI** — epoch.ai | Benchmarks plus long-term trend data (compute, costs) | Research-grade |
| 6 | **Ollama library** — ollama.com/library | Models you can run **locally** on your computer | Practical for local use; no quality scores |
| 7 | Aggregators: **BenchLM** (benchlm.ai), **LLM-Stats**, Onyx, Swfte | Many benchmarks combined | Convenient, but mix sources. Check the original numbers. |

**Live snapshot (Artificial Analysis via OpenRouter, 6 Nov 2026), intelligence index:**
Claude Opus 5.5 59.1 · GPT-6 Astra 56.9 · GPT-6.1 Sol 54.6 · Claude Sonnet 5.5 54.5 · Qwen3.8 Max 53.4 · GPT-6.1 Terra 51.3 · Gemini 4 Argon 50.4 · Claude Fable 5.1 50.0 (highest coding 80.7 and agentic 57.2 in this set).
**Most used on OpenRouter right now:** cheap fast models like DeepSeek V4.1 Flash, GLM 5.3 Flash and GPT-6 Luna, which shows that "most popular" mostly means "cheap and good enough."

**Beginner bookmarks:** **OpenRouter** (prices and what people use) + **Artificial Analysis** (independent quality and speed). Add **Hugging Face** if you want open or local models.

---

## Sources (main)
- registry.modelcontextprotocol.io · github.com/modelcontextprotocol/registry · mcp-trust.com
- hal.cs.princeton.edu · swebench.com · snorkel.ai/leaderboard/terminal-bench · vals.ai/benchmarks/terminal-bench-4 · arena.ai/leaderboard/agent · epoch.ai/benchmarks · scale.com/blog/leaderboard · en.wikipedia.org/wiki/METR
- android.gadgethacks.com (F-Droid & verification) · thenewstack.io (F-Droid "existential") · androidauthority.com (F-Droid update, date slid to 2027) · howtogeek.com · f-droid.org · makeuseof.com (safe APK sites) · securelist.com (APKPure 2021 trojan) · discuss.privacyguides.net · discuss.grapheneos.org
- openrouter.ai/rankings · openrouter.ai/compare · artificialanalysis.ai/models · benchlm.ai · huggingface.co
