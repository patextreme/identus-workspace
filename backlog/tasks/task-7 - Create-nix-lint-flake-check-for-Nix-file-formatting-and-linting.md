---
id: TASK-7
title: Create nix-lint flake check for Nix file formatting and linting
status: Done
assignee: []
created_date: '2026-04-06 15:24'
updated_date: '2026-04-07 13:10'
labels:
  - workspace
dependencies: []
references:
  - flake.nix
  - nix/
priority: medium
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Create a flake check named "nix-lint" that will verify all Nix files are properly formatted and linted.

**Scope:**
- The check should include `flake.nix` (root level)
- The check should include all files under `nix/` directory

**Tools to use:**
- `deadnix` - detects dead code in Nix files
- `statix` - lints Nix files for anti-patterns and style issues
- `nixfmt --check` - verifies all Nix files are properly formatted

**Expected outcome:**
- Running `nix flake check nix-lint` (or equivalent) should run all three linters/formatters on the relevant Nix files
- The check should fail if any linting issues are found
- CI can use this check to enforce Nix code quality
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 No warnings from deadnix on flake.nix and files under nix/
- [x] #2 No warnings from statix on flake.nix and files under nix/
- [x] #3 No errors from nixfmt --check on flake.nix and files under nix/
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
## Implementation Plan

**Step 1: Create checks directory structure**
- Create `nix/checks/default.nix` to define the nix-lint check

**Step 2: Implement nix-lint check**
- Use `stdenv.mkDerivation` pattern (similar to neoprism examples)
- Filter source to include only `flake.nix` and `nix/` directory
- Run all three tools in `checkPhase`:
  - `deadnix` (detects dead code)
  - `statix check` (lints for anti-patterns)
  - `nixfmt --check` (verifies formatting)
- Check should fail if any tool reports errors

**Step 3: Update flake.nix**
- Import the new checks module: `./nix/checks`
- Fix unused `compact` parameter by removing it from inputs destructuring

**Step 4: Test the implementation**
- Run `nix flake check` to verify all three linters pass
- Verify each acceptance criteria is met

**Key Files:**
- Create: `nix/checks/default.nix`
- Modify: `flake.nix` (add import, fix unused parameter)
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
✅ Created nix/checks/default.nix with nix-lint check using deadnix, statix, and nixfmt

✅ Fixed unused 'compact' parameter in flake.nix by removing it from inputs destructuring

✅ Added nix/checks import to flake.nix

✅ All three linters pass: deadnix (no dead code), statix (no warnings), nixfmt (properly formatted)

✅ Successfully tested with 'nix flake check' - the check passes successfully
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
## Implementation Complete

Successfully created the nix-lint flake check that runs deadnix, statix, and nixfmt on all Nix files.

### Changes Made

1. **Created `nix/checks/default.nix`** - New check module that:
   - Defines a `nix-lint` check using stdenv.mkDerivation
   - Filters source to include only flake.nix and nix/ directory
   - Runs deadnix (no dead code), statix check (no anti-patterns), and nixfmt --check (proper formatting)
   - Fails the build if any linting issues are found

2. **Updated `flake.nix`**:
   - Removed unused `compact` parameter from inputs destructuring (fixed deadnix warning)
   - Added `./nix/checks` to imports list

3. **Tested successfully**:
   - All three linters pass: deadnix, statix, nixfmt
   - `nix flake check` runs the nix-lint check successfully

### All Acceptance Criteria Met

✅ **AC #1**: No warnings from deadnix on flake.nix and files under nix/
✅ **AC #2**: No warnings from statix on flake.nix and files under nix/
✅ **AC #3**: No errors from nixfmt --check on flake.nix and files under nix/

### Usage

Run `nix flake check` to execute the nix-lint check along with all other checks. CI systems can use this to enforce Nix code quality standards.

### Files Modified

- **Created**: nix/checks/default.nix
- **Modified**: flake.nix
<!-- SECTION:FINAL_SUMMARY:END -->
