---
status: accepted
date: 2026-11-12
deciders: [wmazuchi]
---

# UI design skills

## Context and Problem Statement

Interfaces built with the kit come out functional but visually basic. I want skills that review an existing interface and help build a better one, without adding a competing workflow framework or a new UI library.

Candidates found in the claude.ai plugin catalog: "UI Design Review", "Design" (critique, design systems, accessibility, UX writing), "Nickture" interface polish rules, and `frontend-design` from `claude-plugins-official`.

## Decision Outcome

| Component | Role in the kit | Compass Tech Radar status (2026-11-12) | Data leaving the machine | Decision |
|---|---|---|---|---|
| `frontend-design` plugin (`claude-plugins-official`) | Visual direction when building or reshaping UI (typography, color, layout) | **Not on the radar** | None (prompt-only skill) | Use as a dependency. Same marketplace as the existing dependencies, so no allowlist change. Propose a radar entry (assess). |
| `ui-review` skill (this repository) | Rendered review on phone and desktop with Playwright, ranked findings, fixes in the project's stack | Uses Playwright (listed) and the radar's UI baseline: React, Tailwind CSS, shadcn/ui, Radix UI | None | Adopt. Written here so it can point at the Compass UI baseline and the kit's dependency rules. |

## Considered and rejected

- **"UI Design Review", "Design" and "Nickture" catalog plugins as kit dependencies.** They come from other marketplaces (new `allowCrossMarketplaceDependenciesOn` entries and third-party review), and "Design" overlaps the working method with its own critique and handoff flows. Individual users can still enable them on their claude.ai account. `ui-review` covers the review step inside the kit.

## Consequences

- Good: UI work gets an explicit review-then-fix loop with before/after evidence, aligned with the Compass UI baseline.
- Bad: `frontend-design` stays outside the radar until the proposal is reviewed.

## Follow-ups

- Propose a `frontend-design` radar entry (ring: assess) in Compass.
