---
id: TASK-3
title: Add midnight-did devshell to flake.nix
status: Done
assignee: []
created_date: '2026-04-06 09:06'
updated_date: '2026-04-06 09:24'
labels: []
dependencies: []
references:
  - flake.nix
  - nix/devshell.nix
  - midnight-did/
priority: medium
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Create a new devshell named "midnight-did" in `nix/devshell.nix` that cd's to the `midnight-did/` subdirectory in its shellHook. This will make it convenient to work on the midnight-did submodule by automatically changing to its directory when entering the devshell.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 The devshell includes git, nix, nodejs_24, and just packages
- [x] #2 The devshell includes a shellHook that changes to the midnight-did directory
- [x] #3 The devshell can be entered with `nix develop .#midnight-did`
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
**Packages to include:**
- git
- nix
- nodejs_24 (Node.js 24)
- just
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
## Summary

Added a new `midnight-did` devshell to `nix/devshell.nix` that:

- **Packages included**: git, nix, nodejs_24, and just
- **shellHook**: Automatically changes to the `midnight-did/` subdirectory when entering the devshell
- **Usage**: `nix develop .#midnight-did`

This makes it convenient to work on the midnight-did submodule by automatically changing to its directory upon entering the devshell.

### Files Modified
- `nix/devshell.nix` - Added `devShells.midnight-did` configuration

### Verification
All acceptance criteria met and verified.
<!-- SECTION:FINAL_SUMMARY:END -->
