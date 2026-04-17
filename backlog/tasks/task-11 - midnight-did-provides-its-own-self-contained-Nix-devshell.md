---
id: TASK-11
title: midnight-did provides its own self-contained Nix devshell
status: To Do
assignee:
  - ai-agent
created_date: '2026-04-07 07:43'
updated_date: '2026-04-17 19:05'
labels:
  - midnight-did
  - workspace
dependencies: []
references:
  - nix/devshells/midnight-did.nix
  - nix/devshells/default.nix
  - flake.nix
documentation:
  - midnight-did/README.md
priority: medium
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Make the midnight-did project fully self-contained by eliminating its dependency on the shared workspace-level nix configuration — this includes migrating both the devshell and the compact-midnight package definition into the midnight-did submodule.

**Why:** Each project that can provide its own Nix devshell should do so, reducing coupling with the shared nix configuration and making it easier for repos to be used standalone.

**Design:** The compact-midnight package will be migrated into the midnight-did submodule alongside the devshell. Since compact-midnight is only referenced by the midnight-did devshell, removing it from the workspace is safe. The package definition from `nix/packages/compact-midnight.nix` will be incorporated into the new self-contained midnight-did flake.

**Benefits:**
- Project-specific devshell and package definitions live with the project
- Reduces coupling with the shared nix configuration
- Makes it easier for the midnight-did repo to be used standalone

### Required packages

| Package | Version | Notes |
|---|---|---|
| `docker` | — | CLI tool |
| `git` | — | Version control |
| `just` | — | Command runner |
| `nix` | — | Package manager |
| `nodejs_24` | — | Node.js runtime |
| `compact-midnight` | v0.5.1 | Midnight compiler |
| `playwright` | — | Browser automation |
| `playwright-driver.browsers` | — | Browser binaries for Playwright |
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 #1 All packages listed in the **Required packages** table are available and executable in the new devshell — verifiable by running `cd midnight-did && nix develop -c bash -c 'docker --version && git --version && just --version && node --version'`
- [ ] #2 #2 The devshell sets the same environment variables as the current workspace-level devshell: `PLAYWRIGHT_BROWSERS_PATH` pointing to `playwright-driver.browsers`, and `PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true`
- [ ] #3 #3 The devshell launches and functions independently from within the midnight-did directory without referencing the workspace-level flake — verifiable by `cd midnight-did && nix develop -c bash -c 'echo Success'` succeeding with no dependency on the workspace-level flake
- [ ] #4 #4 `midnight-did/README.md` is updated to reflect the new devshell usage instructions
- [ ] #5 #5 The midnight-did submodule includes its own package definition for compact-midnight (v0.5.1), making the devshell fully self-contained with no dependency on the workspace-level package
- [ ] #6 #6 The workspace-level nix configuration contains no midnight-did devshell definition or compact-midnight package definition
- [ ] #7 #7 The midnight-did project's existing test suite passes when run within the new self-contained devshell
<!-- AC:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [ ] #1 Other workspace devshells remain unaffected after the removal (no regressions)
- [ ] #2 `nix flake check` passes at the workspace root after the removal
<!-- DOD:END -->
