<dev-kit-rules>
# Dev Kit rules (loaded at every session start)

These rules apply the Ituran Compass policy (`system-foundation` blueprint and Tech Radar) to everyday work. When a repository's own `AGENTS.md` is stricter, it wins.

## 1. Working method
- Follow the Compass `agentic-coding-workflow` Tech Radar entry as the working method. For non-trivial work, look it up with the Compass MCP (`search_knowledge`) before starting.
- Use the curated skills shipped with this kit (adopted selectively from Superpowers, per the Compass radar):
  - `dev-kit:brainstorming`: before any feature or behavior change.
  - `dev-kit:test-driven-development`: while implementing.
  - `dev-kit:systematic-debugging`: for any bug or unexpected behavior.
  - `dev-kit:requesting-code-review`: before calling a branch ready.
  - `dev-kit:ui-review`: when a web interface looks basic or confusing, or before calling a UI change ready. It uses `frontend-design` for visual direction.
- Brownfield safety: before changing an existing flow, add characterization tests at the boundary that flow promises, against real dependencies. Close auth, secret, and data-loss gaps before cleanup.
- Do not adopt competing workflow frameworks (agent swarms, other methodology plugins).

## 2. Memory (Compass Memory)
- Before brainstorming or debugging, search Compass for prior decisions, gotchas, and operational knowledge (`search_knowledge`, e.g. `source_type: memory`, `adr`, `technology`).
- Before building, check Compass systems and the Tech Radar (Compass-first reuse).
- When you learn something durable that another session or teammate will need, propose recording it with `record_memory` and wait for the human to confirm. Never record secrets, credentials, customer data, or personal data.

## 3. Current libraries and APIs (Context7 + LSP)
- Before writing code that uses an external library, read the version from the project manifest (package.json, pyproject.toml/requirements.txt, go.mod, Cargo.toml, *.csproj, ...) and consult that version's docs through Context7.
- Never use deprecated or removed APIs. If the LSP reports `deprecated`, replace the call with the recommended API.
- A task is not done while the LSP reports errors in the changed files.
- Context7 is for public library documentation only. Never send internal code, secrets, or customer data in its queries.

## 4. Dependencies (Trivy + Compass supply-chain rules)
- Prefer technologies in the Compass Tech Radar `adopt`/`trial` rings. Anything outside the adopted path needs an ADR.
- Respect the npm 14-day cooldown: do not install a package version published less than 14 days ago.
- Routine version bumps come from Renovate pull requests, not ad hoc upgrades. Add or upgrade a dependency only when the task requires it, and say why in the PR.
- After adding or changing a dependency, run Trivy locally: `trivy fs --scanners vuln --severity HIGH,CRITICAL .`
- CRITICAL findings block the change. An accepted CVE goes in `.trivyignore` with a rationale and a review date. The Trivy gate in CI is authoritative; the local scan is an early signal.

## 5. Security (Security Guidance)
- Treat Security Guidance warnings as blocking: fix them or justify them explicitly in the PR.
- Secrets stay out of git, logs, images, and client bundles. Never invent credentials, owners, vendors, or dates: ask, or leave them out.

## 6. Testing (Playwright and the Compass evidence bar)
- Prefer acceptance tests over the running system through its public interface. For web UI, use Playwright.
- Do not mock in-process collaborators or the storage the system owns. Mock only what cannot be run.
- Cover each protected capability with at least one denied-attempt test.

## 7. Git and GitHub
- Work on a branch. Never commit directly to the default branch, and never merge your own pull request. Exception: in a single-owner repository, you may merge after the owner approves the diff in chat, and the merge commit references that approval.
- Never execute these yourself; prepare them for a named human: production changes, deployments, rollbacks, deleting or overwriting data/branches/environments, accepting vendor terms, OAuth consent, account settings.
- All committed artifacts (code, docs, identifiers, comments, UI text) are in English. Conversation may be in Portuguese.
- PR descriptions include the plan summary, the tests run, and the Trivy result for dependency changes.

## Completion report (required before calling any task done)
Report explicitly:
1. **What ran:** commands, test layers, and scans, with their results.
2. **What failed:** failures, with the action taken or still pending.
3. **What was not verified:** anything you could not run or check, and why.
4. **Checklist:** no LSP errors in changed files; Trivy clean or justified; no pending Security Guidance warnings; no secrets in the diff.
</dev-kit-rules>
