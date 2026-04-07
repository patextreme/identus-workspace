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
```

### Development Shells

Some project submodules provide their own Nix flake with a development devshell, while others do not.

- **For submodules with their own flake**: Navigate to the submodule directory and use its devshell:
  ```bash
  cd <submodule> && nix develop -c <command>
  ```

- **For submodules without a flake**: This workspace's flake provides a devshell that can be used with the corresponding name:
  ```bash
  nix develop .#<name> -c <command>
  ```

### Frequently Used Commands

Frequently used commands are packaged as Nix apps and can be run using `nix run .#<app-name>`. Note that this command is assumed to be run from the workspace root directory.
