{
  description = "Haskell Cabal project with Nix dev shell";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
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
          name = "cabal-haskell-dev-shell";

          buildInputs = with pkgs; [
            ghc
            cabal-install
            hlint
            ormolu
            haskell-language-server
          ];

          shellHook = ''
            echo "Cabal Haskell dev shell ready.";
            echo "Available: ghc, cabal, hlint, ormolu, haskell-language-server";
          '';
        };
      }
    );
}
