---
id: TASK-17
title: CLI rejects conflicting mnemonic flags immediately with clear error
status: To Do
assignee: []
created_date: '2026-04-15 16:30'
updated_date: '2026-04-16 02:53'
labels:
  - neoprism
dependencies:
  - TASK-15
references:
  - 'https://github.com/hyperledger-identus/neoprism/pull/255'
priority: low
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Address PR #255 review feedback point 4: Enforce mutual exclusivity of `--embedded-wallet-mnemonic` and `--embedded-wallet-mnemonic-file` at the argument-parsing level, so that the CLI provides a standard error message and improved help text before the program reaches `resolve_mnemonic`.

## Background

PR #255 (https://github.com/hyperledger-identus/neoprism/pull/255) introduced `--embedded-wallet-mnemonic-file` as a mutually exclusive alternative to `--embedded-wallet-mnemonic`. Currently, mutual exclusivity is enforced only at runtime in the `resolve_mnemonic()` function in `lib.rs`. The reviewer suggests enforcing this at the argument-parsing level as defense-in-depth and for better UX (standard error + improved help text).

## Current Behavior

When both `--embedded-wallet-mnemonic` and `--embedded-wallet-mnemonic-file` are provided, the CLI accepts both values without complaint. The error is only raised later when `resolve_mnemonic()` is called, producing a custom `anyhow` error message.

## Desired Behavior

1. The CLI rejects the conflicting combination at parse time with a standard error message
2. The `--help` text notes the conflict
3. The `resolve_mnemonic()` conflict branch remains as a safety net for programmatic callers (do not remove it)
4. The `resolve_mnemonic_conflict_returns_error` test still passes (it tests the function directly, not through the CLI)

## Key Decisions

- **`resolve_mnemonic()` unchanged**: The runtime check remains as a safety net. Removing it would weaken validation for non-CLI callers. Keeping it is defense-in-depth (reviewer's own suggestion: "The current `resolve_mnemonic` validation still has value").
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Providing both flags at the CLI produces a standard parser-level error at parse time (not a runtime error)
- [ ] #2 The resolve_mnemonic() function remains unchanged — its conflict branch stays as a safety net for programmatic callers
- [ ] #3 The existing resolve_mnemonic_conflict_returns_error unit test still passes
- [ ] #4 A new CLI-level integration test verifies that the argument parser rejects the conflicting combination
<!-- AC:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [ ] #1 All new and existing tests pass
- [ ] #2 Just check passes
<!-- DOD:END -->
