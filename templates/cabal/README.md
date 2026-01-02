# Cabal Haskell template

Usage:

```sh
nix flake init -t github:hypatia-tile/nix-darwin#cabal
nix develop # enter dev shell with ghc, cabal, hlint, fourmolu

cabal build
cabal test
cabal run
```
