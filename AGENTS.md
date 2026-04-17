# AGENTS.md — Workspace Guide

This is a **git submodule workspace** for developing on the [Identus](https://github.com/hyperledger-identus) ecosystem. Each subdirectory is an independent repository with its own tech stack, CI, and development workflow.

## Repository Structure

| Submodule | Tech Stack | Entrypoint |
|-----------|------------|------------|
| `cloud-agent/` | Scala 3.3.5, SBT | `build.sbt` |
| `sdk-ts/` | TypeScript, Yarn workspaces, Nx | `package.json` |
| `midnight-did/` | Node.js 24+, npm workspaces, Midnight Compact | `package.json` |
| `lace-kyc/` | TypeScript, tsup, Vitest | `package.json` |
| `neoprism/` | Rust, cargo, Just | `Cargo.toml` |
| `nix/` | Nix flake modules | `flake.nix` (root) |
| `backlog/` | Task tracking (non-code) | `config.yml` |

**All submodules are git submodules.** Always `git clone --recurse-submodules` or `git submodule update --init --recursive`.

## Nix Flake Workflow

The workspace uses [Nix flakes](https://nixos.wiki/wiki/Flakes) for development environments.

### Nix Devshells

Some project submodules provide their own Nix flake with a development devshell, while others do not.

- **For submodules with their own flake**: Navigate to the submodule directory and use its devshell:
  ```bash
  cd <submodule> && nix develop -c <command>
  ```

- **For submodules without a flake**: This workspace's flake provides a devshell that can be used with the corresponding name:
  ```bash
  nix develop .#<name> -c <command>
  ```

### Nix Apps

Frequently used commands are packaged as Nix apps and can be run using `nix run .#<app-name>`. Note that this command is assumed to be run from the workspace root directory.

## Project-Specific Instructions

Each submodule has its own instruction file. **Read these first when working in that project:**

| Project | Instruction File |
|---------|-----------------|
| `neoprism/` | [`AGENTS.md`](neoprism/AGENTS.md) — Rust/Scala/Python guidelines |
| `lace-kyc/` | [`CLAUDE.md`](lace-kyc/CLAUDE.md) — KYC Issuer Agent context |
| `midnight-did/` | [`README.md`](midnight-did/README.md) — Component overview and running pipeline |

## Git Submodule Gotchas

1. **Submodules track commits, not branches by default.**
   - After `git submodule update`, you're in detached HEAD.
   - Checkout a branch explicitly if you intend to push: `git checkout main`

2. **Updating a submodule to latest:**
   ```bash
   cd <submodule>
   git pull origin main
   cd ..
   ```

3. **Never force-push to submodules** — they are independent repositories with their own CI.

4. **Check `.gitmodules`** to understand submodule URLs and paths.

5. **⚠️ NEVER update submodules automatically.**
   - Do **not** run `git pull`, `git submodule update`, or any other command that changes a submodule's commit as part of your normal workflow.
   - Submodule updates must only happen when the **user explicitly requests** it (e.g., "update the sdk-ts submodule", "pull latest for cloud-agent").
   - If you notice a submodule is out of date, mention it to the user but **do not** update it on your own.

## Multi-Repo Workspace Guidelines

This workspace contains multiple independent repositories (submodules). When working across projects:

### Backlog Task Labeling

**All backlog tasks must include a label identifying the related project.** This is essential for tracking and filtering tasks across the multi-repo workspace.

| Label | Project |
|-------|--------|
| `cloud-agent` | Cloud Agent (Scala) |
| `sdk-ts` | TypeScript SDK |
| `midnight-did` | Midnight DID |
| `lace-kyc` | Lace KYC |
| `neoprism` | Neoprism (Rust) |
| `workspace` | Workspace-wide / cross-project tasks |

When creating or updating backlog tasks:
1. Always add the appropriate project label
2. For tasks spanning multiple projects, add all relevant labels
3. For workspace-wide changes (e.g., CI updates, devshell changes), use the `workspace` label

### Backlog Task Assignment

When working on backlog tasks and you need to set an assignee:

- **Always use "ai-agent" as the assignee** when setting an assignee
- This allows for flexible task ownership and visibility across the team
- Tasks assigned to "ai-agent" indicate they are being handled by an AI assistant

---

For deeper context, start with the project-specific instruction files linked above.
