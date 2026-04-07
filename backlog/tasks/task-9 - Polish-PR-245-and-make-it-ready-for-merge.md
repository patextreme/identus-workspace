---
id: TASK-9
title: 'Polish PR #245 and make it ready for merge'
status: Done
assignee:
  - ai-agent
created_date: '2026-04-06 16:23'
updated_date: '2026-04-07 16:11'
labels:
  - neoprism
dependencies: []
references:
  - 'https://github.com/hyperledger-identus/neoprism/pull/245'
priority: high
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Review and polish the changes in https://github.com/hyperledger-identus/neoprism/pull/245 to prepare it for merging. The task involves:

1. Review the PR changes thoroughly
2. Address any code review feedback
3. Ensure all tests pass
4. Update documentation if needed
5. Ensure the PR follows project contribution guidelines
6. Resolve any merge conflicts
7. Verify CI/CD pipeline passes

**Note:** Check the submodule `@neoprism/` to explore the codebase and checkout the branch for review.

## PR #245 Readiness Assessment

1. **🔴 Critical:** Update `docs/src/configuration/submitter.md` and `indexer.md` to reflect the new `--dlt-sink-type`/`--dlt-source-type` paradigm and document the embedded wallet
2. **🟡 Recommended:** Run `just check` and confirm it passes (DoD)
3. **🟢 Optional:** Add `embedded-wallet` feature to `nix/checks/neoprism-checks.nix` clippy gate
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 [Critical] Update `docs/src/configuration/submitter.md` to reflect the new `--dlt-sink-type` paradigm and document the embedded wallet
- [x] #2 [Critical] Update `docs/src/configuration/indexer.md` to reflect the new `--dlt-source-type` paradigm and document the embedded wallet
- [x] #3 [Recommended] Verify `just check` passes
- [x] #4 [Optional] Add `embedded-wallet` feature to `nix/checks/neoprism-checks.nix` clippy gate
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
## Implementation Plan

### AC #1: Update `docs/src/configuration/submitter.md`
- Document the new `--dlt-sink-type` enum (cardano-wallet | embedded-wallet)
- Refactor existing Cardano Wallet section with updated flag names:
  - `--cardano-wallet-url` / `NPRISM_CARDANO_WALLET_URL` (renamed from `--wallet-base-url`)
  - `--cardano-wallet-wallet-id` / `NPRISM_CARDANO_WALLET_WALLET_ID` (renamed from `--wallet-id`)
  - `--cardano-wallet-passphrase` / `NPRISM_CARDANO_WALLET_PASSPHRASE` (renamed from `--wallet-passphrase`)
  - `--cardano-wallet-payment-addr` / `NPRISM_CARDANO_WALLET_PAYMENT_ADDR` (renamed from `--payment-address`)
- Add new Embedded Wallet section with flags:
  - `--embedded-wallet-bin` / `NPRISM_EMBEDDED_WALLET_BIN`
  - `--embedded-wallet-submit-api-url` / `NPRISM_EMBEDDED_WALLET_SUBMIT_API_URL`
  - `--embedded-wallet-blockfrost-url` / `NPRISM_EMBEDDED_WALLET_BLOCKFROST_URL`
  - `--embedded-wallet-blockfrost-api-key` / `NPRISM_EMBEDDED_WALLET_BLOCKFROST_API_KEY`
  - `--embedded-wallet-mnemonic` / `NPRISM_EMBEDDED_WALLET_MNEMONIC`
- Add a DLT Sink Comparison section explaining trade-offs

### AC #2: Update `docs/src/configuration/indexer.md`
- Document the new `--dlt-source-type` enum (oura | dbsync | blockfrost)
- Update DLT source sections to reflect they are now selected via `--dlt-source-type` instead of implicitly by providing a flag
- Move `--cardano-network` into the Network section (now shared across all commands)
- Keep existing Oura, DB-Sync, Blockfrost sections with updated flag names (they remain the same)

### AC #3: Verify `just check` passes
- Run `just check` and confirm no failures

### AC #4 (Optional): Add embedded-wallet feature to nix clippy gate
- Add `cargo clippy -p identus-did-prism-submitter --all-targets --features embedded-wallet -- -D warnings` to `nix/checks/neoprism-checks.nix`
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
All 4 acceptance criteria completed:
- AC#1: Rewrote submitter.md with --dlt-sink-type docs, Cardano Wallet (updated flag names), Embedded Wallet section, and DLT Sink Comparison
- AC#2: Rewrote indexer.md with --dlt-source-type docs, restructured Oura/DB-Sync/Blockfrost as sub-sections, Common Options table
- AC#3: `just check` passes (build, tests, formatting, tools checks all green)
- AC#4: Added embedded-wallet clippy gate to nix/checks/neoprism-checks.nix

Finalization review: Verified all 4 staged files against CLI source code. All flag names, env vars, and enum values in submitter.md and indexer.md match cli.rs exactly. cli.rs doc comment fix for embedded_wallet_submit_api_url is accurate (field is Option<String>, not required). nix clippy gate follows existing pattern.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
## Changes

Four files staged on the `embedded-wallet` branch to polish PR #245 for merge:

### 1. `docs/src/configuration/submitter.md` — Rewritten
- Documents the new `--dlt-sink-type` selector (`cardano-wallet` | `embedded-wallet`)
- Cardano Wallet section with updated flag names (`--cardano-wallet-url`, `--cardano-wallet-wallet-id`, `--cardano-wallet-passphrase`, `--cardano-wallet-payment-addr`)
- New Embedded Wallet section covering all 5 flags including submission modes (Submit API vs Blockfrost)
- Added DLT Sink Comparison section with operational guidance

### 2. `docs/src/configuration/indexer.md` — Rewritten
- Documents the new `--dlt-source-type` selector (`oura` | `dbsync` | `blockfrost`)
- Restructured into dedicated Oura / DB-Sync / Blockfrost sections with flag tables
- Added Common DLT Source Options section (`--cardano-network`, `--index-interval`, `--confirmation-blocks`)
- Preserved existing DLT Source Comparison and How Configuration Works sections

### 3. `bin/neoprism-node/src/cli.rs` — Doc comment fix
- Fixed `embedded_wallet_submit_api_url` description: clarified that when omitted, transactions fall back to Blockfrost submission (field is `Option<String>`, not required)

### 4. `nix/checks/neoprism-checks.nix` — CI gate
- Added `cargo clippy -p identus-did-prism-submitter --all-targets --features embedded-wallet -- -D warnings` to the Nix checks, ensuring the `embedded-wallet` feature is CI-gated alongside the existing `cardano-wallet` gate

## Verification
- All flag names and env vars in docs verified against `cli.rs` struct definitions
- All enum values verified against `DltSinkType` / `DltSourceType` enums
- `just check` passes (build, tests, formatting, clippy)
- No new warnings or regressions introduced
<!-- SECTION:FINAL_SUMMARY:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [x] #1 Running 'just check' passes
<!-- DOD:END -->
