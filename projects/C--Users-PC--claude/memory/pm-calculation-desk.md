---
name: pm-calculation-desk
description: "Yazeed's PM Calculation Desk project â€” file locations, architecture, Drive copy, and plan to publish it on his new blog domain"
metadata: 
  node_type: memory
  type: project
  originSessionId: 1be91c38-4abb-4cd7-95d4-cf5c1baf46f2
---

"The Project Manager's Calculation Desk" â€” a single-page interactive PM calculator + teaching reference built July 2026. 14 domains, 33 calculators, 99 metrics (EVM, burn rate, estimation/PERT, float, crashing, resources, communication channels, risk/EMV, decision trees, quality/Six Sigma, finance/NPV, procurement/PTA/FPIF/CPIF, agile, Lean/Little's Law). Every calculator explains what it measures, each parameter's meaning, and how to read the result (color-coded verdicts).

- Source: `C:\Users\PC\Documents\pm-calculations\` â€” index.html, styles.css, data.js (all calculator definitions, data-driven), app.js (renderer). Bundled single-file copy: pm-calculation-desk.html (built by inlining CSS+JS; adding calculators = edit data.js only, then re-bundle).
- Plain ES5 scripts (no modules) so it works over file://; data.js has `module.exports` for Node-based formula testing (all formulas verified against PMP textbook values).
- Design: editorial warm-paper theme, Fraunces + Inter, accent #2b49c9, dark chalk formula strips.
- Credit links to his LinkedIn in sidebar + page footer.
- Google Drive copy: "PM Calculation Desk.html", file id `1ET8OmEdlHk6enCiAqEdJHbS4_HLoyPJv`.

**Status (as of 2026-07-07): LIVE at https://yazeed.blog**
- Homepage (`index.html`) + calculator (`pm-calculation-desk.html`) deployed to Hostinger `public_html` (hPanel File Manager, manual upload)
- Hosted on Hostinger Business plan (renewed 2026-07-07); domain also at Hostinger
- Homepage: topbar reads "by: Yazeed Alotaibi" with LinkedIn â†— and Email (mailto) buttons; RMP/PRINCE2 hero pills removed per Yazeed. 4 cards: calculator (live) + 3 "coming soon" placeholders (Dashboard, AI Scope Generator, WBS Toolkit)
- To add a new tool: upload `.html` to Hostinger `public_html`, then update the card `href` in `index.html`
- Local source for the website: `C:\Users\PC\Documents\yazeed-website\` (exact mirror of public_html)
- **Handoff docs**: `AGENTS.md` written in both `yazeed-website\` and `pm-calculations\` (full context for Codex/other AI assistants â€” Yazeed also works on this project in Codex)
