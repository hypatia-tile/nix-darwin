{
  description = "Haskell Stack project with Nix dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "stack-haskell-shell";
          buildInputs = with pkgs; [
            stack
            ghc
            hlint
            ormolu
            haskell-language-server
          ];
        };

        shellHook = ''
          echo "Stack Haskell shell ready."
          echo "Available: stack, ghc, hlint, ormolu"
          echo "GHC version in this shell:"
          ghc --numeric-version || echo "ghc not found?"
        '';
      }
    );
}
