---
id: TASK-15
title: >-
  New feature: add --embedded-wallet-mnemonic-file CLI flag for file-based
  secret loading
status: Done
assignee: []
created_date: '2026-04-15 04:49'
updated_date: '2026-04-15 11:21'
labels:
  - neoprism
dependencies: []
references:
  - 'https://github.com/hyperledger-identus/neoprism/pull/245'
  - >-
    https://github.com/hyperledger-identus/neoprism/pull/245#pullrequestreview-2376505278
priority: medium
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
New feature from PR #245 review feedback (https://github.com/hyperledger-identus/neoprism/pull/245). Covers review point 2.

**Note:** Check the submodule `neoprism/` to explore the codebase.

## Background

Currently `NPRISM_EMBEDDED_WALLET_MNEMONIC` passes the mnemonic via an environment variable. Environment variables can leak via `/proc`, logging, crash dumps, etc. This is a security concern for production deployments.

## Desired Outcome

Add a `--embedded-wallet-mnemonic-file` CLI flag (env var: `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE`) as a safer alternative that reads the mnemonic from a file at runtime. This allows users to:
- Store the mnemonic as a Docker/Kubernetes secret mounted as a file
- Set file permissions to restrict access
- Avoid exposing the mnemonic in process environment, `/proc/<pid>/environ`, crash dumps, or log leaks

Providing both `--embedded-wallet-mnemonic` and `--embedded-wallet-mnemonic-file` simultaneously must be treated as a configuration error.

## References
- PR #245 review comment by yshyn-iohk (2026-04-09): https://github.com/hyperledger-identus/neoprism/pull/245#pullrequestreview-2376505278
- Reviewer noted: "Consider supporting a file-based secret (e.g., `--embedded-wallet-mnemonic-file`) as a safer alternative in a follow-up."

The test mnemonic for CI/compose artifacts is: `mimic candy diamond virus hospital dragon culture price emotion tell update give faint resist faculty soup demand window dignity capital bullet purity practice fossil` (test-only, never for mainnet).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 `--embedded-wallet-mnemonic-file` / `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` CLI flag reads mnemonic from the specified file path
- [x] #2 Providing both `--embedded-wallet-mnemonic` and `--embedded-wallet-mnemonic-file` results in a clear error and program exit
- [x] #3 The embedded wallet resolves its mnemonic from either the existing env var or the new file-based option
- [x] #4 Documentation (`docs/src/configuration/submitter.md`) covers the new file-based option as a secure alternative
- [x] #5 The Python compose generator supports `mnemonic_file` as an alternative to `mnemonic` in `EmbeddedWalletSink`, with validation rejecting conflicting configuration
- [x] #6 The `prism-test` Docker compose uses file-based mnemonic mounting (read-only) instead of the raw environment variable
- [x] #7 A test-only mnemonic artifact file is available for Docker compose use, clearly marked as test-only
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
### 1. Rust CLI — `bin/neoprism-node/src/cli.rs`

Add `--embedded-wallet-mnemonic-file` / `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` (`Option<PathBuf>`) to `EmbeddedWalletArgs`. Update both mnemonic args' help text to note mutual exclusivity.

### 2. Rust runtime — `bin/neoprism-node/src/lib.rs`

Add `resolve_mnemonic(value, file) → Result<String>`: both → error, neither → error, value → passthrough, file → read + trim. Change `init_dlt_sink` return type to `Result`. Add 6 unit tests.

### 3. Python compose generator — `tools/compose_gen/services/neoprism.py`

Make `mnemonic` optional (`str | None`), add `mnemonic_file: str | None`, add `@model_validator` for both/neither rejection. In `mk_service`, mount mnemonic file read-only to `/run/secrets/mnemonic` and set `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` accordingly. Only set env-var mnemonic when `mnemonic` is present.

### 4. Python compose stack — `tools/compose_gen/stacks/prism_test.py`

Switch `EmbeddedWalletSink` from `mnemonic=wallet_mnemonic` to `mnemonic_file="./mnemonic.txt"`. Remove `wallet_mnemonic` variable.

### 5. Docker compose & artifact — `docker/prism-test/`

Create `mnemonic.txt` with test mnemonic (git-tracked). In `compose-ci-embedded-wallet.yml`, replace env-var mnemonic with `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` pointing to `/run/secrets/mnemonic` + read-only bind mount.

### 6. Docs

`docs/src/configuration/submitter.md`: add flag row + security recommendation for file-based option. `docker/prism-test/README.md`: add ⚠️ test-only warning.

### 7. Verify

`cargo test --all-features` and `just check`.

**Key decisions:** file resolution is CLI-layer only (library keeps `Arc<str>`); `init_dlt_sink` returns `Result` for clean error propagation; Pydantic validates at model level; test mnemonic git-tracked with clear warnings.
<!-- SECTION:PLAN:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
## Summary

Added `--embedded-wallet-mnemonic-file` / `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` CLI flag as a secure alternative to the existing `--embedded-wallet-mnemonic` env-var-based option for the embedded wallet submitter.

### Changes

**Rust CLI (`bin/neoprism-node/src/cli.rs`):**
- Added `--embedded-wallet-mnemonic-file` argument with `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` env var support to `EmbeddedWalletArgs`
- Added documentation noting mutual exclusivity with `--embedded-wallet-mnemonic`

**Rust runtime (`bin/neoprism-node/src/lib.rs`):**
- New `resolve_mnemonic()` function that accepts `Option<&str>` and `Option<&Path>`, returns `anyhow::Result<String>`
- Validates mutual exclusivity (both provided → error) and required-at-least-one (neither provided → error)
- Reads file contents and trims leading/trailing whitespace
- Changed `init_dlt_sink()` return type from `Arc<dyn DltSink>` to `anyhow::Result<Arc<dyn DltSink>>` to propagate validation errors
- 6 new unit tests: direct value, file read, whitespace trimming, conflict error, missing-provider error, missing-file error

**Python compose generator (`tools/compose_gen/services/neoprism.py`):**
- `EmbeddedWalletSink.mnemonic` changed from `str` to `str | None = None`
- Added `EmbeddedWalletSink.mnemonic_file: str | None = None`
- Added `@model_validator` rejecting both/neither provided
- `mk_service()` now builds volumes list from `options.volumes` and conditionally mounts mnemonic file as read-only bind (`{host_path}:/run/secrets/mnemonic:ro`), overriding the env var to the container path
- `_add_dlt_sink_env()` only sets `NPRISM_EMBEDDED_WALLET_MNEMONIC` when `mnemonic` is not None

**Python compose stack (`tools/compose_gen/stacks/prism_test.py`):**
- Replaced `mnemonic=wallet_mnemonic` with `mnemonic_file="./mnemonic.txt"` for embedded wallet configuration
- Removed `wallet_mnemonic` variable (moved to external file)

**Docker compose (`docker/prism-test/compose-ci-embedded-wallet.yml`):**
- Replaced `NPRISM_EMBEDDED_WALLET_MNEMONIC` env var with `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE: /run/secrets/mnemonic`
- Added read-only volume mount `./mnemonic.txt:/run/secrets/mnemonic:ro`

**Mnemonic file (`docker/prism-test/mnemonic.txt`):**
- New file containing the test mnemonic, tracked in git

**Docs (`docs/src/configuration/submitter.md`):**
- Added `--embedded-wallet-mnemonic-file` row to the Embedded Wallet flag table
- Added security recommendation paragraph favoring file-based option in production
- Updated Embedded Wallet description from "in-process" to "as a subprocess" for accuracy

**README (`docker/prism-test/README.md`):**
- Added ⚠️ WARNING about test-only mnemonic
- Updated compose-ci-embedded-wallet.yml description to mention file-based mnemonic mounting

**Embedded wallet library (`lib/did-prism-submitter/src/dlt/embedded_wallet.rs`):**
- Added comment explaining the semaphore concurrency limit of 1 (UTXO contention)

### Tests Run

- `cargo test --all-features` — all 24 `neoprism-node` unit tests pass (including 6 new `resolve_mnemonic_*` tests)
- `just check` — formatting, linting, compose generation, build, and full test suite all pass

### Risks / Follow-ups

- The `docker/prism-test/mnemonic.txt` file contains a test-only mnemonic tracked in git. This is intentional per the task requirements (clearly marked with WARNING in README), but teams should ensure it's never used on mainnet.
- No changes to the embedded wallet library itself (`EmbeddedWalletSinkConfig.mnemonic` remains `Arc<str>`) — the file→string resolution is a CLI-layer concern.
<!-- SECTION:FINAL_SUMMARY:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [x] #1 All new and existing tests pass
- [x] #2 Just check passes
- [x] #3 Unit tests cover file reading, whitespace trimming, and conflict error behavior for the new file-based mnemonic option
<!-- DOD:END -->
