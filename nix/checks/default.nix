{
  perSystem =
    { pkgs, ... }:
    {
      checks.lint-nix = pkgs.callPackage ./lint-nix.nix { };
    };
}
