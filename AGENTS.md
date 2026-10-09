# AGENTS.md

Owning system: claude

## What this repository is

A personal Claude Code plugin marketplace (`wagner-plugins`) with one plugin, `dev-kit`. It is developer tooling with no deployment and no owned business state, so it has no Compass system entry of its own. The owning system above is the Compass entry for Claude (the AI assistant used by the engineering team).

The kit packages:

- curated Superpowers skills (`plugins/dev-kit/skills/`, see `plugins/dev-kit/UPSTREAM.md`);
- plugin dependencies from `claude-plugins-official`: Context7, GitHub, Playwright, Security Guidance;
- session rules (`plugins/dev-kit/rules/workflow.md`) injected by a SessionStart hook. They align daily work with the Compass `system-foundation` blueprint and Tech Radar.

Component choices and their Tech Radar status are recorded in `docs/architecture/decisions/0001-component-selection.md`.

## Conventions

- Everything committed is in English.
- Work on a branch and open a pull request. Do not commit to `main` directly. This is a single-owner repository: the agent may merge only after the owner approves the diff in chat.
- Any change to the plugin needs a semver bump of `version` in `plugins/dev-kit/.claude-plugin/plugin.json`.
- Validate before committing: `claude plugin validate ./plugins/dev-kit` and `claude plugin validate .`.
- Adding a dependency from a new marketplace also requires adding it to `allowCrossMarketplaceDependenciesOn` in `.claude-plugin/marketplace.json`, plus an ADR if the tool is not in the Compass Tech Radar.
- Vendored Superpowers skills change only as reviewed diffs against upstream, with the patch table in `UPSTREAM.md` kept current.
- Commits use the GitHub noreply address `68665517+wmazuchi@users.noreply.github.com`.

## Common tasks

- **Install the kit on a machine:** follow `INSTALL.md`.
- **Change the rules:** edit `plugins/dev-kit/rules/workflow.md`, bump the version, validate, then open a PR.
