{
  description = "Haskell project with Nix dev shell";

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
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      # dev shell for development
      devShells.default = pkgs.mkShell {
        name = "haskell-dev-shell";
        buildInputs = with pkgs; [
          haskellPackages.ghc
          haskellPackages.cabal-install
          haskellPackages.hlint
          haskellPackages.hunit
        ];
        shellHook = ''
          echo "Haskell dev shell ready. ghc + cabal + hlint."
        '';
      };

      # optional: a simple package definition, if you want
      packages.default = pkgs.stdenv.mkDerivation {
        pname = "haskell-project";
        version = "0.1.0.0";
        src = ./.;
        buildInputs = [pkgs.ghc];
      };
    });
}
