{
  description = "Personal Identus development workspace";

  # IOG's public binary cache
  nixConfig = {
    extra-substituters = "https://cache.iog.io";
    extra-trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./nix/apps
        ./nix/devshells
        ./nix/checks
      ];
      systems = [ "x86_64-linux" ];

      perSystem =
        { system, ... }:
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config.unfree = true;
          };
        };
    };
}
