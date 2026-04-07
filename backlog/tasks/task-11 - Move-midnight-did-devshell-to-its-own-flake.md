---
id: TASK-11
title: Move midnight-did devshell to its own flake
status: To Do
assignee: []
created_date: '2026-04-07 07:43'
updated_date: '2026-04-07 13:10'
labels:
  - midnight-did
dependencies: []
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Move the midnight-did devshell configuration from @nix/devshells/ to the nix flake directly in the midnight-did repository.

This will:
- Remove the devshell definition from the centralized nix/devshells/ directory
- Add a flake.nix to the midnight-did repo with its own devshell
- Ensure the devshell remains self-contained within the project

Benefits:
- Project-specific devshell lives with the project
- Reduces coupling with the shared nix configuration
- Makes it easier for the midnight-did repo to be used standalone
<!-- SECTION:DESCRIPTION:END -->
