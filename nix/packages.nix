{ pkgs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      packages = {
        compact-midnight = pkgs.callPackage ./compact-midnight.nix { };
      };
    };
}
