# identus-workspace

Personal development workspace for the [Identus](https://github.com/hyperledger-identus) ecosystem.

## Structure

| Directory | Description |
|---|---|
| `neoprism/` | NeoPrism — Prism Node |
| `cloud-agent/` | Cloud Agent |
| `sdk-ts/` | TypeScript SDK |
| `midnight-did/` | Midnight DID — Decentralized Identity |
| `lace-kyc/` | Lace KYC — KYC functionality for Lace project |
| `nix/` | Nix flake modules |

## Setup

### Prerequisites

- [Nix](https://nixos.org/download/) with flake support enabled
- Git

### Getting Started

```bash
# Clone with submodules
git clone --recurse-submodules git@github.com:patextreme/identus-workspace.git

# Or initialize submodules in an existing clone
git submodule update --init --recursive

# Enter the development shell
nix develop
```

### Frequently Used Commands

```bash
# List all available just recipes
just --list

# Format Nix files (flake.nix and nix/**/*.nix)
just format
```
