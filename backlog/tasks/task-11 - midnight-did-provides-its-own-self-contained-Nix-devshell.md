---
id: TASK-11
title: midnight-did provides its own self-contained Nix devshell
status: To Do
assignee:
  - ai-agent
created_date: '2026-04-07 07:43'
updated_date: '2026-04-17 10:21'
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
Make the midnight-did project fully self-contained by eliminating its dependency on the shared workspace-level nix configuration.

**Why:** Each project that can provide its own Nix devshell should do so, reducing coupling with the shared nix configuration and making it easier for repos to be used standalone.

**Benefits:**
- Project-specific devshell lives with the project
- Reduces coupling with the shared nix configuration
- Makes it easier for the midnight-did repo to be used standalone
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 The devshell provides the same packages as the current workspace-level devshell (`nix/devshells/midnight-did.nix`): `docker`, `git`, `just`, `nix`, `nodejs_24`, `compact-midnight` (v0.5.1), `playwright`, and `playwright-driver.browsers`
- [ ] #2 The devshell sets the same environment variables as the current workspace-level devshell: `PLAYWRIGHT_BROWSERS_PATH` pointing to `playwright-driver.browsers`, and `PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true`
- [ ] #3 The devshell can be launched via `cd midnight-did && nix develop -c <command>` without depending on the workspace-level flake
- [ ] #4 The workspace-level nix configuration no longer contains any midnight-did devshell definition (remove `nix/devshells/midnight-did.nix` and its import in `nix/devshells/default.nix`)
- [ ] #5 `midnight-did/README.md` is updated to reflect the new devshell usage instructions
<!-- AC:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [ ] #1 Other workspace devshells remain unaffected after the removal (no regressions)
- [ ] #2 `nix flake check` passes at the workspace root after the removal
<!-- DOD:END -->
