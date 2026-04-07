{
  imports = [
    ./midnight-did.nix
  ];

  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          docker
          git
          just
          nix
          nixfmt
          which
        ];
      };
    };
}
