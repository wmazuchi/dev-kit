# Vendored skills

The skills below are a curated subset of [obra/superpowers](https://github.com/obra/superpowers) (MIT, see `LICENSE-superpowers`). The Compass Tech Radar adopts Superpowers selectively: curate each skill, never import the whole collection.

- Upstream commit: `8ca22dba9a94f28898bbce59f2537ff4d87c747d` (2026-09-25, plugin version 6.4.2)
- Vendored: `brainstorming`, `test-driven-development`, `systematic-debugging`, `requesting-code-review`
- "Brownfield safety" from the radar's core list has no matching upstream skill. It is covered by rule 1 in `rules/workflow.md`.

## Local patches

| Skill | Change | Reason |
|---|---|---|
| brainstorming | Removed the visual companion (local browser server, scripts) | Smaller surface; not part of the curated core |
| brainstorming | Hand-off goes to "write the implementation plan" (Compass `agentic-coding-workflow`) instead of the non-vendored `writing-plans` skill | Only curated skills ship |
| brainstorming | Specs saved to `docs/specs/`, committed on a branch, in English | Compass repository shape and language rule |
| brainstorming | Removed the optional `elements-of-style` reference | Not vendored |
| test-driven-development | Added the "Ituran evidence bar" section | Compass `system-foundation` testing policy |
| test-driven-development | Dropped the `writing-skills` cross-reference | Not vendored |
| systematic-debugging | References point to `dev-kit:test-driven-development` and the completion checklist | Non-vendored skills removed |
| systematic-debugging | Removed upstream test/creation-log files | Upstream development artifacts |
| requesting-code-review | Example plan path set to `docs/specs/` | Compass repository shape |

## Updating from upstream

Review upstream changes as diffs, never as a blind overwrite. Re-apply the patches above, bump `version` in `.claude-plugin/plugin.json`, and record the new upstream commit here.
