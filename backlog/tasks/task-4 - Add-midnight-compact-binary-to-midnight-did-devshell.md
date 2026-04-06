---
id: TASK-4
title: Add midnight-compact binary to midnight-did devshell
status: Done
assignee: []
created_date: '2026-04-06 09:08'
updated_date: '2026-04-06 10:01'
labels: []
dependencies: []
references:
  - 'github:LFDT-Minokawa/compact'
  - 'github:LFDT-Minokawa/compact/tree/v0.30.0'
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Update the midnight-did devshell to include the compact binary from https://github.com/LFDT-Minokawa/compact. Consume the flake output from that repo and make the binary available in the devshell environment.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 The compact binary is available in the devshell environment (e.g., via nix develop)
- [x] #2 The compact binary can be executed and displays help/version info
- [x] #3 The compact binary can process a DID document (e.g., compact, decompact operations)
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
## Implementation Plan

### 1. Add flake input in `flake.nix`
```nix
inputs = {
  # ... existing inputs ...
  compact = {
    url = "github:LFDT-Minokawa/compact/v0.30.0";
    inputs.zkir.follows = "zkir";  # if zkir is added as input
    inputs.onchain-runtime-v3.follows = "onchain-runtime-v3";
  };
};
```

### 2. Update midnight-did devshell in `nix/devshell.nix`
```nix
devShells.midnight-did = pkgs.mkShell {
  packages = with pkgs; [
    git
    nix
    nodejs_24
    just
    inputs.compact.packages.${system}.compactc  # Add this
  ];
  shellHook = ''
    cd midnight-did
  '';
};
```

### 3. Run `nix flake update` to update lock file

### 4. Test the binary
```bash
nix develop .#midnight-did
compactc --version  # or --help
```

## Key Findings from Investigation
- **Binary name:** `compactc` (not `compact`)
- **Package:** `packages.compactc` in the flake outputs
- **Latest stable tag:** v0.30.0
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Successfully added `compactc` (v0.30.0) from `LFDT-Minokawa/compact` to the `midnight-did` devshell.

### Changes
- **flake.nix**: Added `compact` input (`github:LFDT-Minokawa/compact/v0.30.0`)
- **nix/devshell.nix**: Added `inputs`/`system` parameters; included `inputs.compact.packages.${system}.compactc`

### Verification
All acceptance criteria verified: binary available, `--version`/`--help` work, DID document compilation successful with `--skip-zk` flag.

### Notes
- Binary name is `compactc` (not `compact`)
- No follow inputs needed for this workspace
<!-- SECTION:FINAL_SUMMARY:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [x] #1 flake inputs reference LFDT-Minokawa/compact repo
- [x] #2 devshell.packages includes the compact binary
- [x] #3 compact --version or compact --help works in devshell
- [x] #4 Test compact operation on a sample DID document
<!-- DOD:END -->
