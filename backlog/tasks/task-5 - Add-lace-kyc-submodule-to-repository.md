---
id: TASK-5
title: Add lace-kyc submodule to repository
status: Done
assignee: []
created_date: '2026-04-06 14:39'
updated_date: '2026-04-07 08:08'
labels: []
dependencies: []
priority: medium
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Add the submodule https://github.com/input-output-hk/lace-kyc to the repository.

This involves:
1. Adding the submodule using `git submodule add`
2. Ensuring proper configuration in `.gitmodules`
3. Documenting the submodule's purpose and usage if needed

The lace-kyc submodule likely contains KYC (Know Your Customer) related functionality for the Lace project.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Submodule is properly added using SSH URL (git@github.com:input-output-hk/lace-kyc.git)
- [x] #2 .gitmodules file is properly configured with SSH URL
- [x] #3 Submodule can be initialized and updated via git submodule commands
- [x] #4 Documentation is updated to reflect the new submodule if required
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
## Summary
Successfully added the lace-kyc submodule to the repository.

### Changes Made
- Added git submodule for lace-kyc at path `lace-kyc/`
- Used SSH URL: `git@github.com:input-output-hk/lace-kyc.git`
- Updated `.gitmodules` with proper submodule configuration
- Updated `README.md` to document the new submodule

### Implementation Details
- Submodule initialized at commit `0dda995` on `main` branch
- All git submodule commands work correctly (`git submodule status`, `git submodule update --init --remote`)
- Changes staged on branch `lace-kyc`

### Verification
All acceptance criteria verified:
1. ✅ Submodule added using SSH URL
2. ✅ .gitmodules properly configured with SSH URL
3. ✅ Submodule can be initialized and updated via git submodule commands
4. ✅ Documentation updated (README.md)

### Note
README.md modification is currently unstaged and should be staged before final commit.
<!-- SECTION:FINAL_SUMMARY:END -->
