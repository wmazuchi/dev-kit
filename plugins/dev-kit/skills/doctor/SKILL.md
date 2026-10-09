---
name: doctor
description: Checks that the dev-kit setup is complete and healthy (plugins, LSPs, Compass MCP, Trivy, GitHub token). Use when the user asks to check, diagnose or validate the dev-kit.
---

# dev-kit doctor

Run every check below without changing anything. Finish with a status table (OK / MISSING / WARNING) and the suggested actions.

1. **Plugins:** run `claude plugin list`. These must be enabled: `dev-kit@wagner-plugins`, plus `context7`, `github`, `playwright` and `security-guidance` (all `@claude-plugins-official`).
   - WARNING if a full `superpowers` plugin or `episodic-memory` is also installed. The kit ships a curated subset of Superpowers and uses Compass Memory, so the full sets duplicate or conflict with them.
2. **LSPs:** for each installed `*-lsp` plugin, confirm its binary is on PATH (`typescript-language-server`, `pyright-langserver`, `gopls`, `rust-analyzer`). Suggest the missing LSP for the current project's languages.
3. **Compass MCP:** run `claude mcp list` and confirm `compass` is listed and connected. If it is not, show the command from INSTALL.md step 3.
4. **Trivy:** run `trivy --version`. If it is missing, show the install command for the user's OS.
5. **GitHub:** check that `GITHUB_PERSONAL_ACCESS_TOKEN` is set, without printing its value.
6. **Rules:** confirm the `<dev-kit-rules>` block is present in this session's context. If it is not, the SessionStart hook did not run: suggest `/reload-plugins` or a new session, and on Windows check that Git for Windows (Git Bash) is installed.
