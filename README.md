# dev-kit

A personal Claude Code setup, packaged as a plugin marketplace and aligned with the Ituran Compass policy. One install makes it available in **every project** on **any machine**.

## What the `dev-kit` plugin contains

| Piece | Source | Role |
|---|---|---|
| Curated skills: `brainstorming`, `test-driven-development`, `systematic-debugging`, `requesting-code-review` | Vendored from obra/superpowers ([UPSTREAM.md](plugins/dev-kit/UPSTREAM.md)) | Working method, adopted selectively per the Compass radar |
| `ui-review` skill | This repository | Senior-designer review of a running UI (phone and desktop), ranked fixes, then improvements in the project's own stack |
| `doctor`, `update` skills | This repository | Diagnose and update the setup |
| Session rules ([workflow.md](plugins/dev-kit/rules/workflow.md)) | This repository | Compass-aligned rules injected at every session start |
| context7 | claude-plugins-official | Version-specific library docs |
| github | claude-plugins-official | Issues, branches, pull requests |
| playwright | claude-plugins-official | End-to-end tests |
| security-guidance | claude-plugins-official | Warnings on risky edits |
| frontend-design | claude-plugins-official | Distinctive, production-grade interface design |

Installed alongside the plugin, not bundled in it:

- **Compass MCP:** memory, ADRs, Tech Radar and systems.
- **Trivy:** dependency vulnerability scanning.
- **LSP plugins:** only for language servers present on the machine.

Why each component was chosen, and what was rejected, is recorded in [ADR 0001](docs/architecture/decisions/0001-component-selection.md) and [ADR 0002](docs/architecture/decisions/0002-ui-design-skills.md).

## Install (Claude does it for you)

Open Claude Code in any folder and say:

```
Install the dev-kit by following https://github.com/wmazuchi/dev-kit/blob/main/INSTALL.md
```

Afterwards:

- `/dev-kit:doctor` diagnoses the setup.
- `/dev-kit:update` updates the kit and its dependencies.

### Manual alternative

In Claude Code:

```
/plugin install dev-kit --marketplace wmazuchi/dev-kit
```

Or with the scripts (they also set up the Compass MCP and LSPs):

- Windows: `powershell -ExecutionPolicy Bypass -File .\bootstrap.ps1`
- Linux/macOS: `./bootstrap.sh`

The Compass login (`claude mcp login compass`) and the `GITHUB_PERSONAL_ACCESS_TOKEN` variable are completed by you.

## Publish (first time)

Double-click `publish.cmd`. It needs only git, and it pushes this folder to `wmazuchi/dev-kit` using the GitHub noreply address. The full output goes to `publish.log`.

## Maintenance

- Change the rules: edit `plugins/dev-kit/rules/workflow.md`, bump `version` in `plugin.json`, validate, then open a PR. On each machine, run `/dev-kit:update`.
- Disable the kit for one project: `claude plugin disable dev-kit@wagner-plugins --scope local`.
- Conventions for changing this repository are in [AGENTS.md](AGENTS.md).
