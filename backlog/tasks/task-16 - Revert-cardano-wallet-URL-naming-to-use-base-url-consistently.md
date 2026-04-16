---
id: TASK-16
title: Revert cardano-wallet URL naming to use base-url consistently
status: To Do
assignee:
  - ai-agent
created_date: '2026-04-15 09:12'
updated_date: '2026-04-16 15:25'
labels:
  - neoprism
dependencies: []
references:
  - 'https://github.com/hyperledger-identus/neoprism/pull/245'
priority: medium
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
PR #245 renamed `--cardano-wallet-base-url` / `NPRISM_CARDANO_WALLET_BASE_URL` / `cardano_wallet_base_url` to `--cardano-wallet-url` / `NPRISM_CARDANO_WALLET_URL` / `cardano_wallet_url`. This rename was unnecessary and the original naming is more precise — the value is a base URL (e.g. `http://cardano-wallet:8090/v2`) from which specific API paths are derived. Reverting keeps the env var, CLI flag, and Rust field all consistent and semantically accurate.

All three levels revert together:
- CLI flag: `--cardano-wallet-url` → `--cardano-wallet-base-url`
- Env var: `NPRISM_CARDANO_WALLET_URL` → `NPRISM_CARDANO_WALLET_BASE_URL`
- Rust field: `cardano_wallet_url` → `cardano_wallet_base_url`

All other `NPRISM_CARDANO_WALLET_*` / `--cardano-wallet-*` options (`wallet-id`, `passphrase`, `payment-addr`) are untouched.
<!-- SECTION:DESCRIPTION:END -->

<!-- AC:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 The CLI flag is --cardano-wallet-base-url
- [ ] #2 The env var is NPRISM_CARDANO_WALLET_BASE_URL
- [ ] #3 The Rust field is cardano_wallet_base_url
- [ ] #4 Error messages reference --cardano-wallet-base-url (not the old name)
- [ ] #5 Documentation (submitter.md, generated cli-options.md) lists --cardano-wallet-base-url and NPRISM_CARDANO_WALLET_BASE_URL
- [ ] #6 No references to --cardano-wallet-url or NPRISM_CARDANO_WALLET_URL (without _BASE) remain anywhere in the neoprism codebase
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Key files affected:
- `cli.rs` — rename the field `cardano_wallet_url` → `cardano_wallet_base_url` and update the `env = "..."` attribute
- `lib.rs` — update all references to the field (field access, local variable, expect message)
- `submitter.md` — update the flag name and env var in the docs table
- `neoprism.py` — update the env var key; then run `python -m compose_gen.main` from `neoprism/tools/` to regenerate the 5 compose files in `docker/prism-test/`

Note: `docs/src/references/cli-options.md` is auto-generated from clap help text and needs no manual edit.
<!-- SECTION:NOTES:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [ ] #1 Generated compose files (docker/prism-test/) are regenerated via compose_gen, not manually edited
- [ ] #2 cargo clippy and cargo test pass with no new warnings or failures
- [ ] #3 `just check` recipe passes with no errors
<!-- DOD:END -->
