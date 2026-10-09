# Publishes this folder to https://github.com/wmazuchi/dev-kit using git only.
# Usage: double-click publish.cmd  (or: powershell -ExecutionPolicy Bypass -File .\publish.ps1)
# Everything that happens is logged to publish.log in this folder.
$ErrorActionPreference = "Continue"
$Repo   = "wmazuchi/dev-kit"
$Remote = "https://github.com/$Repo.git"
Set-Location $PSScriptRoot
$Log = Join-Path $PSScriptRoot "publish.log"
Set-Content -Path $Log -Value "publish.ps1 - $(Get-Date -Format s)" -Encoding UTF8

function Log([string]$m) { Write-Host $m; Add-Content -Path $Log -Value $m -Encoding UTF8 }
function G {
  Log "> git $($args -join ' ')"
  $out = & git @args 2>&1
  $code = $LASTEXITCODE
  foreach ($l in $out) { Log "  $l" }
  return $code
}

try {
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "git not found. Install it with: winget install Git.Git  (then reopen PowerShell)" }
  Log ("git: " + (git --version))

  if (-not (Test-Path ".git")) {
    if ((G init) -ne 0) { throw "git init failed" }
  }
  G checkout -B main | Out-Null

  # Commit identity: always the GitHub noreply address (Compass ADR 0011 precedent)
  G config user.name "wmazuchi" | Out-Null
  G config user.email "68665517+wmazuchi@users.noreply.github.com" | Out-Null

  G add -A | Out-Null
  if (git status --porcelain) {
    if ((G commit -m "feat: dev-kit marketplace (Superpowers + complementos)") -ne 0) { throw "commit failed" }
  } else { Log "Nothing new to commit." }

  if (git remote | Select-String -Quiet "^origin$") { G remote set-url origin $Remote | Out-Null }
  else { G remote add origin $Remote | Out-Null }

  # May open the browser for GitHub sign-in (Git Credential Manager)
  if ((G fetch origin) -ne 0) { throw "cannot reach $Remote. Check that the repository exists and that you are signed in to GitHub." }

  $remoteMain = git ls-remote --heads origin main
  if ($remoteMain) {
    Log "The repository already has commits; merging and keeping the kit files."
    if ((G merge origin/main --allow-unrelated-histories -X ours -m "merge: initial GitHub history") -ne 0) { throw "merge failed" }
  }

  if ((G push -u origin main) -ne 0) { throw "push failed" }
  Log "`nOK: published to https://github.com/$Repo"

  Log "Visibility is managed in https://github.com/$Repo/settings > Danger Zone > Change visibility"

  $ans = Read-Host "`nInstall the dev-kit on this machine now? (y/N)"
  if ($ans -match "^[yYsS]") { $env:KIT_REPO = $Repo; & "$PSScriptRoot\bootstrap.ps1" }
}
catch {
  Log "`nERROR: $_"
  Log "Share publish.log with Claude for analysis."
}
