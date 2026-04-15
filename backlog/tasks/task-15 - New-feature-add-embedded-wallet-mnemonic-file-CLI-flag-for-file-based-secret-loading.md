---
id: TASK-15
title: >-
  New feature: add --embedded-wallet-mnemonic-file CLI flag for file-based
  secret loading
status: To Do
assignee: []
created_date: '2026-04-15 04:49'
updated_date: '2026-04-15 08:47'
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
- [ ] #1 `--embedded-wallet-mnemonic-file` / `NPRISM_EMBEDDED_WALLET_MNEMONIC_FILE` CLI flag reads mnemonic from the specified file path
- [ ] #2 Providing both `--embedded-wallet-mnemonic` and `--embedded-wallet-mnemonic-file` results in a clear error and program exit
- [ ] #3 The embedded wallet resolves its mnemonic from either the existing env var or the new file-based option
- [ ] #4 Documentation (`docs/src/configuration/submitter.md`) covers the new file-based option as a secure alternative
- [ ] #5 The Python compose generator supports `mnemonic_file` as an alternative to `mnemonic` in `EmbeddedWalletSink`, with validation rejecting conflicting configuration
- [ ] #6 The `prism-test` Docker compose uses file-based mnemonic mounting (read-only) instead of the raw environment variable
- [ ] #7 A test-only mnemonic artifact file is available for Docker compose use, clearly marked as test-only
<!-- AC:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [ ] #1 All new and existing tests pass
- [ ] #2 Just check passes
- [ ] #3 Unit tests cover file reading, whitespace trimming, and conflict error behavior for the new file-based mnemonic option
<!-- DOD:END -->
