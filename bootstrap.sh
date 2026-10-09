#!/usr/bin/env bash
# Installs the dev-kit at USER scope (all projects on this machine).
# Usage: KIT_REPO=owner/repo ./bootstrap.sh
set -uo pipefail
KIT_REPO="${KIT_REPO:-wmazuchi/dev-kit}"

echo ">> Adding marketplaces"
claude plugin marketplace add anthropics/claude-plugins-official || true
claude plugin marketplace add "$KIT_REPO" || true

echo ">> Compass MCP"
if ! claude mcp list 2>/dev/null | grep -q '^compass'; then
  claude mcp add --transport http --scope user compass https://compass.app.ituran.com.br/mcp
  echo "   Run 'claude mcp login compass' to sign in with your Entra identity."
fi

echo ">> Installing the bundle (dependencies install automatically)"
claude plugin install dev-kit@wagner-plugins --scope user

echo ">> Trivy"
command -v trivy >/dev/null 2>&1 && trivy --version | head -1 || echo "   Trivy missing: brew install trivy  (or https://trivy.dev/latest/getting-started/installation/)"

echo ">> LSPs: installed only when the language server exists on this machine"
install_lsp() { # $1 = plugin, $2 = binary, $3 = install hint
  if command -v "$2" >/dev/null 2>&1; then
    claude plugin install "$1@claude-plugins-official" --scope user
  else
    echo "   - skipping $1 ('$2' not found; install with: $3)"
  fi
}
install_lsp typescript-lsp    typescript-language-server "npm i -g typescript typescript-language-server"
install_lsp pyright-lsp       pyright-langserver         "npm i -g pyright"
install_lsp gopls-lsp         gopls                      "go install golang.org/x/tools/gopls@latest"
install_lsp rust-analyzer-lsp rust-analyzer              "rustup component add rust-analyzer"

echo ">> Done. Open Claude Code and run /dev-kit:doctor."
echo "   Reminder: the GitHub plugin needs GITHUB_PERSONAL_ACCESS_TOKEN (fine-grained, least privilege)."
