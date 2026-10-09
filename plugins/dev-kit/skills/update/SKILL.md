---
name: update
description: Updates the dev-kit and its dependencies to their latest versions. Use when the user asks to update the dev-kit or the plugins in this setup.
---

# dev-kit update

1. Record the current versions with `claude plugin list`.
2. Run `claude plugin marketplace update` to refresh every marketplace catalog.
3. Run `claude plugin update dev-kit@wagner-plugins`.
4. Update the dependencies: `claude plugin update <name>@claude-plugins-official` for `context7`, `github`, `playwright`, `security-guidance` and each installed `*-lsp` plugin.
5. Ask the user to run `/reload-plugins`, then `/dev-kit:doctor`.
6. Report which versions changed (compare `claude plugin list` before and after).
