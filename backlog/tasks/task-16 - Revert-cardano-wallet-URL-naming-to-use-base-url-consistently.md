---
id: TASK-16
title: Revert cardano-wallet URL naming to use base-url consistently
status: To Do
assignee: []
created_date: '2026-04-15 09:12'
updated_date: '2026-04-15 10:58'
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

**All three levels revert together:**
- Rust field: `cardano_wallet_url` → `cardano_wallet_base_url`
- CLI flag: `--cardano-wallet-url` → `--cardano-wallet-base-url` (derived from the field name)
- Env var: `NPRISM_CARDANO_WALLET_URL` → `NPRISM_CARDANO_WALLET_BASE_URL`

**Context for implementers:**
- `cli.rs`: rename the field and update the `env = "..."` attribute
- `lib.rs`: update all references to `cardano_wallet_url` → `cardano_wallet_base_url` (field access, local variable, expect message)
- `submitter.md`: update the flag name and env var in the docs table
- `neoprism.py`: update the env var key; then run `python -m compose_gen.main` from `neoprism/tools/` to regenerate the 5 compose files in `docker/prism-test/`
- `docs/src/references/cli-options.md` is auto-generated from clap help text and needs no manual edit
- All other `NPRISM_CARDANO_WALLET_*` / `--cardano-wallet-*` options (`wallet-id`, `passphrase`, `payment-addr`) are untouched
<!-- SECTION:DESCRIPTION:END -->

<!-- AC:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 The cardano wallet URL option uses --cardano-wallet-base-url as the CLI flag, NPRISM_CARDANO_WALLET_BASE_URL as the env var, and cardano_wallet_base_url as the Rust field
- [ ] #2 lib.rs references the renamed field correctly and the expect message mentions --cardano-wallet-base-url
- [ ] #3 Documentation lists --cardano-wallet-base-url and NPRISM_CARDANO_WALLET_BASE_URL
- [ ] #4 No references to --cardano-wallet-url or NPRISM_CARDANO_WALLET_URL (without _BASE) remain anywhere in the neoprism codebase
- [ ] #5 just check passes
<!-- AC:END -->
