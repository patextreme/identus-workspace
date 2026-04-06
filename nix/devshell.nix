{ pkgs, ... }:
{
  perSystem =
    { pkgs, self', ... }:
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

      devShells.midnight-did = pkgs.mkShell {
        packages = with pkgs; [
          # Core tools
          docker
          git
          just
          nix
          nodejs_24
          # Compact compiler from Midnight Network (v0.5.1)
          self'.packages.compact-midnight
          # Playwright for E2E tests
          playwright
          playwright-driver.browsers
          # Raw compact binaries; may be removed if compact-midnight
          # provides compactc and zkir directly
          # inputs.compact.packages.${system}.compactc
          # inputs.compact.inputs.zkir.packages.${pkgs.system}.zkir
          # inputs.compact.inputs.zkir-v3.packages.${pkgs.system}.zkir-v3
        ];
        shellHook = ''
          export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
          export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
          cd midnight-did
        '';
      };
    };
}

