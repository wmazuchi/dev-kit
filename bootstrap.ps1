# Installs the dev-kit at USER scope (all projects on this machine).
# Usage: $env:KIT_REPO="owner/repo"; powershell -ExecutionPolicy Bypass -File .\bootstrap.ps1
$KitRepo = if ($env:KIT_REPO) { $env:KIT_REPO } else { "wmazuchi/dev-kit" }

Write-Host ">> Adding marketplaces"
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin marketplace add $KitRepo

Write-Host ">> Compass MCP"
if (-not (claude mcp list 2>$null | Select-String -Quiet "^compass")) {
  claude mcp add --transport http --scope user compass https://compass.app.ituran.com.br/mcp
  Write-Host "   Run 'claude mcp login compass' to sign in with your Entra identity."
}

Write-Host ">> Installing the bundle (dependencies install automatically)"
claude plugin install dev-kit@wagner-plugins --scope user

Write-Host ">> Trivy"
if (Get-Command trivy -ErrorAction SilentlyContinue) { trivy --version | Select-Object -First 1 }
else { Write-Host "   Trivy missing: winget install AquaSecurity.Trivy" }

Write-Host ">> LSPs: installed only when the language server exists on this machine"
$lsps = @(
  @{ Plugin = "typescript-lsp";    Bin = "typescript-language-server"; Hint = "npm i -g typescript typescript-language-server" },
  @{ Plugin = "pyright-lsp";       Bin = "pyright-langserver";         Hint = "npm i -g pyright" },
  @{ Plugin = "gopls-lsp";         Bin = "gopls";                      Hint = "go install golang.org/x/tools/gopls@latest" },
  @{ Plugin = "rust-analyzer-lsp"; Bin = "rust-analyzer";              Hint = "rustup component add rust-analyzer" }
)
foreach ($l in $lsps) {
  if (Get-Command $l.Bin -ErrorAction SilentlyContinue) {
    claude plugin install "$($l.Plugin)@claude-plugins-official" --scope user
  } else {
    Write-Host "   - skipping $($l.Plugin) ('$($l.Bin)' not found; install with: $($l.Hint))"
  }
}

Write-Host ">> Done. Open Claude Code and run /dev-kit:doctor."
Write-Host "   Reminder: the GitHub plugin needs GITHUB_PERSONAL_ACCESS_TOKEN (fine-grained, least privilege)."
