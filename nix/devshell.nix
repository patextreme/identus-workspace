{ pkgs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt;

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          git
          just
          nix
          nixfmt
          which
        ];
      };
    };
}
