---
id: TASK-2
title: Add just recipe "format" for formatting Nix files in nix/ and flake.nix
status: Done
assignee: []
created_date: '2026-04-06 08:01'
updated_date: '2026-04-06 08:44'
labels:
  - justfile
  - nix
  - formatting
dependencies: []
references:
  - flake.nix
  - nix/devshell.nix
  - README.md
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Create a `justfile` at the **root of this repository** (top level) with a `format` recipe that formats only the top-level `flake.nix` and all `.nix` files inside the `nix/` directory using `nixfmt`.

**Context:**
- `flake.nix` already declares `formatter = pkgs.nixfmt`, so `nix fmt` is available out of the box.
- However, `nix fmt` recursively formats **all** `.nix` files in the repo. Since we only want to target `flake.nix` and `nix/**/*.nix`, the just recipe should **not** delegate to `nix fmt` directly. Instead, it should explicitly invoke `nixfmt` on the specific files.

**Scope:**
- Create a new top-level `justfile` in this repository — **do not modify** the justfile inside the `neoprism/` submodule.
- The `format` recipe should format only:
  - `flake.nix` (top level)
  - `nix/**/*.nix` (all `.nix` files under the `nix/` directory)
- Update `README.md` to include:
  - The `format` recipe usage
  - A section on frequently used commands
  - How to discover available just recipes (e.g. `just --list`)
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 A top-level `justfile` is created in this repository with a `format` recipe
- [x] #2 The `neoprism/justfile` (submodule) is NOT modified
- [x] #3 The `format` recipe formats only `flake.nix` and `nix/**/*.nix` files
- [x] #4 README.md is updated with the `format` recipe usage
- [x] #5 README.md includes a section on frequently used commands
- [x] #6 README.md documents how to discover available just recipes (e.g. `just --list`)
- [x] #7 The `just` package is added to the dev shell (nix/devshell.nix) if not already present
- [x] #8 All existing `.nix` files in `nix/` and top-level `flake.nix` are formatted (no diffs after running `just format`)
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
## TASK-2: Add just recipe "format" for formatting Nix files

### Changes
- **`justfile`** (new): Created a top-level justfile with two recipes:
  - `_default`: Lists all available recipes via `just --list`
  - `format`: Runs `nixfmt` on `flake.nix`, then uses `find -exec nixfmt {} +` to batch-format all `*.nix` files under `nix/`
- **`nix/devshell.nix`**: Added `just` and `nixfmt` packages to the dev shell so contributors have both tools available.
- **`README.md`**: Replaced the narrow "Formatting" section with a broader "Frequently Used Commands" section documenting `just --list`, and `just format`.

### Key decisions
- Used `nixfmt` directly (not `nix fmt`) to avoid recursively formatting all `.nix` files in the repo, matching the scoped requirement of only `flake.nix` and `nix/**/*.nix`.
- Used `find -exec nixfmt {} +` instead of shell `$()` substitution for robustness: handles filenames with special characters, avoids argument length limits, and correctly handles empty result sets.
- `neoprism/justfile` (submodule) was intentionally left untouched.

### Testing
- All 8 acceptance criteria verified against staged changes.
- No diffs on existing `.nix` files beyond the intentional package additions in `devshell.nix`, confirming files were already formatted.
<!-- SECTION:FINAL_SUMMARY:END -->
