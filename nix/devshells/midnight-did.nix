{
  perSystem =
    { pkgs, self', ... }:
    {
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
        ];
        shellHook = ''
          export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
          export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
          cd midnight-did
        '';
      };
    };
}
