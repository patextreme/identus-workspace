---
id: TASK-8
title: 'Address PR #11 review feedback'
status: Done
assignee: []
created_date: '2026-04-06 16:20'
updated_date: '2026-04-07 09:03'
labels: []
dependencies:
  - TASK-5
references:
  - 'https://github.com/input-output-hk/lace-kyc/pull/11'
priority: high
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Review and address all feedback from the GitHub pull request review at https://github.com/input-output-hk/lace-kyc/pull/11

This task involves:
- Reviewing all comments and suggestion from the PR
- Making necessary code changes based on reviewer feedback
- Responding to any questions raised
- Ensuring all requested changes are implemented
- Resolving any conversations once addressed

Note: Check the submodule for context after TASK-5 is completed.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 CLAUDE.md reference to deleted docs/context.md is fixed or removed
- [x] #2 Docker volumes in docker-compose.integration.yml are cleaned up (unused volumes removed or properly mounted)
- [x] #3 TODO comment added for StorablePrivateKey workaround in src/utils/identus/pluto.ts
- [x] #4 @zodyac/zod-mongoose dependency placement in dependencies (not devDependencies) is verified as correct
- [x] #5 AnonCreds limitation is documented with TODO comment or case is removed from storableToCredential method
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
## Summary

Addressed all 5 review feedback items from PR #11.

## Changes Made

### 1. CLAUDE.md Documentation Fix
- Changed `context.md` reference to `./context.md` to clarify file location at project root
- Verified `context.md` exists at root level

### 2. Docker Volumes Cleanup
- Removed unused `mongodb_data` and `postgres_data` volumes from `docker-compose.integration.yml`
- Only `neoprism_data` volume remains (actively mounted by neoprism-standalone service)

### 3. StorablePrivateKey Workaround Documentation
- Added comprehensive TODO comment explaining SDK v8 PrivateKey type limitation
- Documented that `recoveryId`, `raw`, and `index` properties exist at runtime but aren't in public types
- Suggested upstream contribution to Identus SDK team

### 4. @zodyac/zod-mongoose Dependency Verification
- Confirmed correct placement in `dependencies` (not `devDependencies`)
- Package is used at runtime in 7 Mongoose model files under `src/db/models/`

### 5. AnonCreds Limitation Documentation
- Added TODO comment in `storableToCredential` method explaining AnonCreds recovery limitation
- Throwing descriptive error with guidance for future implementation
- Documented that AnonCredsCredential class isn't directly available/exported in SDK v8

## Files Modified
- `CLAUDE.md`
- `docker-compose.integration.yml`
- `src/utils/identus/pluto.ts`

## Testing
- No new tests required (documentation and configuration changes only)
- Verified all referenced files exist and are correctly formatted

## Risks/Follow-ups
- Two TODO comments added for SDK v8 limitations that could be addressed upstream:
  - StorablePrivateKey type enhancement
  - AnonCreds credential recovery support
<!-- SECTION:FINAL_SUMMARY:END -->
