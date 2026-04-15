---
id: TASK-15
title: >-
  New feature: add --embedded-wallet-mnemonic-file CLI flag for file-based
  secret loading
status: To Do
assignee: []
created_date: '2026-04-15 04:49'
updated_date: '2026-04-15 05:06'
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

**Note:** Check the submodule `@neoprism/` to explore the codebase.

## Review Point 2: Support file-based mnemonic for embedded wallet

Currently `NPRISM_EMBEDDED_WALLET_MNEMONIC` passes the mnemonic via an environment variable. Environment variables can leak via `/proc`, logging, crash dumps, etc. This is a security concern for production deployments.

Add a `--embedded-wallet-mnemonic-file` CLI flag (env var: `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE`) as a safer alternative that reads the mnemonic from a file at runtime. This allows users to:
- Store the mnemonic as a Docker/Kubernetes secret mounted as a file
- Set file permissions to restrict access
- Avoid exposing the mnemonic in process environment, `/proc/<pid>/environ`, crash dumps, or log leaks

### Implementation approach
- Add `embedded_wallet_mnemonic_file: Option<PathBuf>` field to the embedded wallet CLI args in `bin/neoprism-node/src/cli.rs`
- At startup, if `--embedded-wallet-mnemonic-file` is provided, read the mnemonic from the specified file path (trim trailing whitespace/newlines)
- If both `--embedded-wallet-mnemonic` and `--embedded-wallet-mnemonic-file` are provided, the program must exit with an error (ambiguous/conflicting configuration — do not silently choose one)
- If neither is provided when `--dlt-sink-type=embedded-wallet`, error out as before
- Update `docs/src/configuration/submitter.md` embedded wallet section to document the new `--embedded-wallet-mnemonic-file` / `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` option
- Update `tools/compose_gen/services/neoprism.py` `EmbeddedWalletSink` model to support `mnemonic_file` as an optional alternative
- Consider adding `--embedded-wallet-mnemonic-file` to compose generator for Docker Secret usage patterns

## References
- PR #245 review comment by yshyn-iohk (2026-04-09): https://github.com/hyperledger-identus/neoprism/pull/245#pullrequestreview-2376505278
- Reviewer noted: "Consider supporting a file-based secret (e.g., `--embedded-wallet-mnemonic-file`) as a safer alternative in a follow-up."
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 #1 Add `--embedded-wallet-mnemonic-file` / `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` CLI flag to `bin/neoprism-node/src/cli.rs` that accepts a PathBuf and reads the mnemonic from the specified file
- [ ] #2 #2 Implement mnemonic resolution logic: read from file, trim whitespace, error out if both `--embedded-wallet-mnemonic` and `--embedded-wallet-mnemonic-file` are provided (conflicting configuration)
- [ ] #3 #3 Update the embedded wallet initialization in `bin/neoprism-node/src/lib.rs` to use the resolved mnemonic from either env var or file
- [ ] #4 #4 Update `docs/src/configuration/submitter.md` to document `--embedded-wallet-mnemonic-file` / `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` as a secure alternative to `--embedded-wallet-mnemonic`
- [ ] #5 #5 Update `tools/compose_gen/services/neoprism.py` EmbeddedWalletSink model to support mnemonic_file as an optional alternative
- [ ] #6 #6 Add unit tests for the new --embedded-wallet-mnemonic-file flag (file reading, trimming, conflict error behavior when both flags are provided)
<!-- AC:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [ ] #1 All new and existing tests pass
- [ ] #2 Just check passes
<!-- DOD:END -->
