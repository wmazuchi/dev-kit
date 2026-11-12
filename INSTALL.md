# Guided installation

> **For the user:** open Claude Code in any folder and say:
> `Install the dev-kit by following https://github.com/wmazuchi/dev-kit/blob/main/INSTALL.md`
>
> **For Claude:** the steps below are for you. Run them in order, say what you are about to do before any step that changes the machine and wait for confirmation, then finish with a report.

## Step 0: Find the kit repository
- If you were given a GitHub URL, take `owner/repo` from it. That is `KIT_REPO`.
- If you are running inside a clone of this repository, get it from `git remote get-url origin`.
- If the repository is private, the user's git credentials must have access to it.

## Step 1: Prerequisites
1. Run `claude --version`. The kit depends on plugins from another marketplace; if step 4 fails for that reason, ask the user to run `claude update` and retry.
2. Detect the OS (Windows/PowerShell, macOS or Linux) and use matching commands.
3. Confirm `git` is installed. On Windows it also provides Git Bash, which the kit's SessionStart hook needs.

## Step 2: Marketplaces
Run these. If a marketplace is already added, move on.
```
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin marketplace add <KIT_REPO>
```

## Step 3: Compass MCP (memory, radar, ADRs)
If `claude mcp list` does not show `compass`, run:
```
claude mcp add --transport http --scope user compass https://compass.app.ituran.com.br/mcp
claude mcp login compass
```
The login uses the user's Entra identity in the browser. The user completes it themselves; never complete OAuth consent on their behalf.

## Step 4: Install the bundle
```
claude plugin install dev-kit@wagner-plugins --scope user
```
This installs the curated skills and session rules, plus these dependencies: context7, github, playwright, security-guidance and frontend-design.

If the full `superpowers` plugin or `episodic-memory` is installed, tell the user they overlap with the kit. Offer to uninstall them, but only uninstall after they confirm.

## Step 5: Trivy
Check `trivy --version`. If it is missing, offer to install it, and install only after the user confirms:
- Windows: `winget install AquaSecurity.Trivy`
- macOS: `brew install trivy`
- Linux: follow https://trivy.dev/latest/getting-started/installation/

## Step 6: LSPs
1. Find out which languages the user works with: ask, or inspect the current directory (package.json/tsconfig → TypeScript; pyproject/requirements → Python; go.mod → Go; Cargo.toml → Rust).
2. For each language, check whether its language server is on PATH:

| Plugin | Binary | How to install the binary |
|---|---|---|
| typescript-lsp | typescript-language-server | `npm i -g typescript typescript-language-server` |
| pyright-lsp | pyright-langserver | `npm i -g pyright` |
| gopls-lsp | gopls | `go install golang.org/x/tools/gopls@latest` |
| rust-analyzer-lsp | rust-analyzer | `rustup component add rust-analyzer` |

3. If a binary is missing, offer to install it and wait for confirmation. Respect the npm 14-day cooldown rule.
4. Install the plugin: `claude plugin install <plugin>@claude-plugins-official --scope user`.

## Step 7: Credentials
- **GitHub:** check whether `GITHUB_PERSONAL_ACCESS_TOKEN` is set, without ever printing it. If it is not set, explain how to create a fine-grained, least-privilege token at https://github.com/settings/personal-access-tokens and how to set it persistently on the user's OS. Never ask for the token in chat and never write it to a file in a repository.

## Step 8: Verify
1. Run `claude plugin list`. Confirm that dev-kit, context7, github, playwright, security-guidance, frontend-design and the chosen LSPs are all enabled.
2. Ask the user to open a new Claude Code session (or run `/reload-plugins`), then run `/dev-kit:doctor`.

## Step 9: Report
Show a table with each component and its status (installed / skipped / pending). Then list the user's pending actions: Compass login, GitHub token, LSP binaries, Trivy.
