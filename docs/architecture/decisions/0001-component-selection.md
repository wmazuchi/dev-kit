---
status: accepted
date: 2026-10-08
deciders: [wmazuchi]
---

# Dev Kit component selection

## Context and Problem Statement

I want one Claude Code setup that is available in every project on any machine. It should keep the agent on current, secure libraries and follow the Ituran Compass policy (`system-foundation` blueprint and Tech Radar).

A first draft bundled the full Superpowers collection, `episodic-memory` and the Socket MCP. A review against Compass found these gaps:

- the radar adopts Superpowers only selectively;
- Trivy is the canonical dependency scanner;
- Compass Memory is the company's cross-session memory;
- committed artifacts must be in English and every repository needs an `AGENTS.md`.

This record captures the resulting selection, so that tools outside the adopted path are explicit rather than implicit.

## Decision Outcome

| Component | Role in the kit | Compass Tech Radar status (2026-10-08) | Data leaving the machine | Decision |
|---|---|---|---|---|
| Claude Code | Harness | Listed (`claude-code`) | Prompts and code, to Anthropic | Adopt (company harness) |
| Superpowers, curated subset | brainstorming, TDD, systematic debugging, requesting code review | Listed (`superpowers`): adopt selectively, curate each skill | None | Adopt the four core skills, vendored with patches (`plugins/dev-kit/UPSTREAM.md`) |
| Compass MCP | Memory, ADRs, radar and systems lookup (`search_knowledge`, `record_memory`) | Company system (Compass) | Queries to the Compass server (Entra-authenticated) | Adopt; replaces `episodic-memory` |
| Trivy | Local dependency vulnerability scan; the CI gate is authoritative | Listed (`trivy`): canonical SCA | None (vulnerability DB download only) | Adopt; replaces Socket |
| Playwright plugin | End-to-end tests for web UI | Listed (`playwright`) | None | Adopt |
| GitHub plugin | Issues, branches, pull requests | GitHub is a listed system under evaluation alongside Azure DevOps | Repository metadata, to GitHub | Adopt for GitHub-hosted repositories only; use a fine-grained, least-privilege token |
| Context7 plugin | Version-specific public library docs | **Not on the radar.** Precedent: enabled in `ituran-bra/TI/platform` | Library names and doc queries, to Context7 | Use, with a guardrail: no internal code, secrets or customer data in queries. Propose a radar entry (assess). |
| Security Guidance plugin | Real-time warnings on risky edits | **Not on the radar** | None (local hooks) | Use as an advisory signal; Semgrep/Trivy in CI stay authoritative. Propose a radar entry (assess). |
| LSP plugins (TypeScript, Pyright, gopls, rust-analyzer) | Diagnostics and deprecation warnings | Language servers for languages on the radar | None | Install only when the language server binary is present |

## Considered and rejected

- **Full Superpowers plugin.** The radar says curate, do not import wholesale.
- **episodic-memory.** Not on the radar. It keeps a local index of every conversation, which can hold personal data (LGPD and data-subject-request risk) outside Compass. Compass Memory covers the durable, shared part.
- **Socket MCP.** Not on the radar, and it duplicates the canonical SCA (Trivy). It is also an extra third-party MCP to allowlist under the MCP security baseline.
- **Snyk.** Adoption is gated on the Veracode usage review.
- **Ruflo / Claude Flow.** A competing orchestration framework that overlaps the curated workflow.

## Consequences

- Good: every component is on the radar or explicitly recorded here, with its data boundary. Dependency checks use the company scanner, and memory lives where teammates can find it.
- Bad: vendored skills need manual, diff-reviewed updates from upstream. Context7 and Security Guidance stay outside the radar until the proposals are reviewed.

## Follow-ups

- Propose `context7` and `security-guidance` radar entries (ring: assess) in Compass.
- The repository is public while it is set up and will be made private afterwards. If this kit becomes a team standard, move it to the `ituran-bra` organization as a private repository (Compass ADR 0011 precedent).
