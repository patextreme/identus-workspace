# List all available recipes
_default:
    @just --list

# Format Nix files (flake.nix and nix/**/*.nix)
format:
    nixfmt flake.nix
    find nix -name '*.nix' -type f -print0 | xargs -0 -r nixfmt
