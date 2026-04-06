---
id: TASK-1
title: Initialize workspace with git submodules and Nix devshell
status: Done
assignee: []
created_date: '2026-04-06 07:01'
updated_date: '2026-04-06 08:01'
labels: []
dependencies: []
references:
  - 'https://github.com/orgs/hyperledger-identus/repositories'
documentation:
  - 'https://flake.parts/'
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Set up the foundational workspace structure for the Identus ecosystem. This workspace aggregates multiple git submodules from the Identus project to facilitate cross-repo development. The initial set of repos to include:

- **neoprism** — `https://github.com/hyperledger-identus/neoprism`
- **cloud-agent** — `https://github.com/hyperledger-identus/cloud-agent`
- **sdk-ts** — `https://github.com/hyperledger-identus/sdk-ts`

The workspace must provide a Nix-based development environment using `flake-parts`, with a clean module structure that separates flake logic into a `nix/` directory while keeping the top-level `flake.nix` minimal. The flake system configuration should focus only on `x86_64-linux`.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Git submodules for `neoprism`, `cloud-agent`, and `sdk-ts` are initialized and tracked in `.gitmodules`
- [x] #2 `flake.nix` exists at the workspace root and uses `flake-parts` (imports from `nix/` directory)
- [x] #3 `nix/devshell.nix` defines a `flake-parts` module with a single `default` devshell
- [x] #4 The flake outputs exactly one devshell: `default`
- [x] #5 `nix develop` successfully enters the development shell (no errors)
- [x] #6 Flake system configuration is set to `x86_64-linux` only
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. **Initialize git submodules** for `neoprism`, `cloud-agent`, and `sdk-ts` under the workspace root
2. **Create `flake.nix`** at the root — minimal, using `flake-parts` and importing `nix/devshell.nix`, with system set to `x86_64-linux`
3. **Create `nix/devshell.nix`** — a `flake-parts` module defining a single `default` devshell with packages: `git`, `nix`, `just`, `which`
4. **Configure** the flake to only support `x86_64-linux` system
5. **Verify** `nix develop` works and enters the shell on x86_64-linux
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Executed all steps. Submodules reactivated from existing local git dirs with --force. Added nixfmt as formatter. All checks pass.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
## TASK-1: Initialize workspace with git submodules and Nix devshell

### What changed
- Initialized three git submodules under the workspace root:
  - `neoprism` → `https://github.com/hyperledger-identus/neoprism.git` (main)
  - `cloud-agent` → `https://github.com/hyperledger-identus/cloud-agent.git` (main)
  - `sdk-ts` → `https://github.com/hyperledger-identus/sdk-ts.git` (main)
- Created `flake.nix` at the workspace root using `flake-parts`, importing from `nix/` directory, scoped to `x86_64-linux` only
- Created `nix/devshell.nix` as a `flake-parts` module defining a single `default` devshell with packages: `git`, `nix`, `just`, `which`
- Configured `nixfmt` as the flake formatter
- Added `README.md` with workspace structure overview, prerequisites, and setup instructions

### Verification
- `nix flake check` passes with no errors
- `nix develop` successfully enters the dev shell
- `nix flake show` confirms exactly one devshell output: `devShells.x86_64-linux.default`
- All three submodules are initialized and pointing to their respective `main` branches

### No risks or follow-ups
Clean foundational setup with no regressions or outstanding issues.
<!-- SECTION:FINAL_SUMMARY:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [x] #1 All Nix files are formatted with nixfmt
- [x] #2 README.md updated with workspace setup instructions
- [x] #3 Workspace structure validated (submodules and flake working)
<!-- DOD:END -->
