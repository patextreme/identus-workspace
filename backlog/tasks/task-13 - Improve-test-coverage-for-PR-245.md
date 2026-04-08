---
id: TASK-13
title: 'Improve test coverage for PR #245'
status: Done
assignee:
  - ai-agent
created_date: '2026-04-07 16:34'
updated_date: '2026-04-08 09:39'
labels:
  - neoprism
dependencies: []
references:
  - 'https://github.com/hyperledger-identus/neoprism/pull/245'
  - 'https://coveralls.io/builds/78706137'
documentation:
  - neoprism/AGENTS.md
priority: medium
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
PR #245 has very low diff coverage. The overall project coverage is 26.82%. We should improve it to pass the bar for the PR gate.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Unit tests for `embedded_wallet.rs` pure-logic functions: Error Display variants, Network::Display, EmbeddedWalletSink::new(), is_retryable_error()
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
## Plan: Improve test coverage for PR #245

### Completed: Phase 1 — `embedded_wallet.rs` pure-logic functions
**File**: `lib/did-prism-submitter/src/dlt/embedded_wallet.rs`
**Test location**: inline `#[cfg(test)]` module in `embedded_wallet.rs`

Tests added (19 total):
1. **Error Display variants** (9 tests) — all 9 Error enum variants tested for correct Display output
2. **Network::Display** (4 tests) — exact string output for all four variants
3. **EmbeddedWalletSink::new()** (1 test) — verifies semaphore permits and config fields
4. **is_retryable_error()** (5 tests) — covers BadInputsUTxO, ValueNotConservedUTxO, combined, unrelated, empty string

### Removed Phases (low value — testing derive macro output, not business logic)
- ~~Phase 2: `did-core/error.rs`~~ — tests `derive_more::Display` and `derive_more::From` macro output, not application logic
- ~~Phase 3: `cli.rs`~~ — tests `clap::ValueEnum` parsing and `#[arg(default_value)]` defaults, not business logic
- ~~Phase 4: `lib.rs` network mapping~~ — trivial match statement already verified by the compiler for exhaustiveness
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
## Phase 1 Complete: embedded_wallet.rs pure-logic tests

Added 19 inline `#[cfg(test)]` tests in `lib/did-prism-submitter/src/dlt/embedded_wallet.rs`:

1. **Error Display variants** (9 tests) — all 9 Error enum variants tested for correct Display output via `.to_string()`:
   - SubprocessSpawn, StdinWrite, SubprocessIo, SubprocessFailed, SubprocessTimeout, CborDecode, SubmitFailed, SubmitApiError, TxHashParse
   - Each test verifies key substrings from the `#[display(...)]` attribute appear in the output

2. **Network::Display** (4 tests) — exact output verification:
   - Mainnet → "mainnet", Preprod → "preprod", Preview → "preview", Custom → "custom"

3. **EmbeddedWalletSink::new()** (1 test) — verifies:
   - Semaphore is initialized with 1 permit
   - Config fields are stored correctly

4. **is_retryable_error()** (5 tests) — covers:
   - BadInputsUTxO → true
   - ValueNotConservedUTxO → true
   - Both patterns combined → true
   - Unrelated string → false
   - Empty string → false

No production code changes required (no visibility modifications needed — test module can access private items).

All tests pass: `cargo test --all-features` ✓
Clippy passes: `cargo clippy --all-targets -- -D warnings` ✓
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
## Summary

Added 19 unit tests to `lib/did-prism-submitter/src/dlt/embedded_wallet.rs` covering pure-logic functions in the new embedded wallet module introduced by PR #245:

- **Error Display** (9 tests) — all `Error` enum variants produce expected output via `.to_string()`
- **Network::Display** (4 tests) — exact string output for Mainnet/Preprod/Preview/Custom
- **EmbeddedWalletSink::new()** (1 test) — verifies semaphore permits and config field initialization
- **is_retryable_error()** (5 tests) — covers both retryable patterns (BadInputsUTxO, ValueNotConservedUTxO), combined case, false negatives, and empty string

No production code changes were needed (private items are accessible from the inline test module).

### Scope reduction

Phases 2–4 were removed from scope after review because they tested third-party derive macro output (`derive_more::Display`/`From`, `clap::ValueEnum`) and trivial compiler-verified match arms rather than application business logic. These tests would add maintenance burden without catching real bugs.
<!-- SECTION:FINAL_SUMMARY:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [x] #1 All new tests pass via `cargo test --all-features`
- [x] #2 `cargo clippy --all-targets -- -D warnings` passes with no new warnings
- [x] #3 Diff coverage for PR #245 is measurably improved for the tested files
<!-- DOD:END -->
