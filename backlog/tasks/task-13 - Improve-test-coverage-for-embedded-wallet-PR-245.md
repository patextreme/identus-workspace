---
id: TASK-13
title: Improve test coverage for embedded wallet PR (#245)
status: To Do
assignee:
  - ai-agent
created_date: '2026-04-07 16:34'
labels:
  - neoprism
dependencies: []
references:
  - 'https://github.com/hyperledger-identus/neoprism/pull/245'
  - 'https://coveralls.io/builds/78688906'
documentation:
  - neoprism/AGENTS.md
priority: medium
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
PR #245 (feat: add embedded wallet support for Cardano transaction submission) has very low diff coverage at **1.56% (4/257 lines)**. The overall project coverage is 26.78%.

The primary gap is in the new `embedded_wallet.rs` module — 255 lines added with **0/110 relevant lines covered (0%)**. This is the core new functionality and needs unit tests.

### Coverage Gaps in Changed Files

| File | Coverage | Notes |
|------|----------|-------|
| `lib/did-prism-submitter/src/dlt/embedded_wallet.rs` | 0/110 (0%) | **Main target** — new EmbeddedWallet DLT sink |
| `lib/did-prism-submitter/src/dlt/cardano_wallet.rs` | 0/27 (0%) | Modified, also 0% coverage |
| `bin/neoprism-node/src/cli.rs` | 0/7 (0%) | CLI additions for embedded wallet config |
| `bin/neoprism-node/src/lib.rs` | 110/487 (22.6%) | New wiring code partially covered |

### Key Areas to Test in `embedded_wallet.rs`

1. **Mnemonic parsing and validation** — valid/invalid mnemonics, wrong word count
2. **Transaction building** — correct CBOR encoding, fee calculation
3. **Retry logic** — transient error handling, max retries exceeded
4. **Error paths** — network failures, invalid responses from cardano-submit-api
5. **Happy path** — successful transaction submission flow

The file introduces a `DltSink` implementation that uses mnemonics to sign Cardano transactions and submits them via the cardano-submit-api. Tests should cover both unit-level logic and integration scenarios where feasible.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Unit tests added for `lib/did-prism-submitter/src/dlt/embedded_wallet.rs` covering mnemonic parsing/validation, transaction building, retry logic, and error handling
- [ ] #2 Diff coverage for the PR improves from 1.56% to at least 60% on Rust source files
- [ ] #3 `embedded_wallet.rs` module coverage reaches at least 70% of relevant lines
- [ ] #4 All new tests pass under `cargo test` in the neoprism workspace
- [ ] #5 No regression in existing tests
<!-- AC:END -->
