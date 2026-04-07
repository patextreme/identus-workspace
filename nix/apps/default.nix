{
  perSystem =
    { pkgs, ... }:
    {
      apps = {
        format-nix = {
          type = "app";
          program = "${pkgs.lib.getExe (pkgs.callPackage ./format-nix.nix { })}";
          meta.description = "Format Nix files using nixfmt";
        };
      };
    };
}
