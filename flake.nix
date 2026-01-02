{
  description = "Shino's Nix-Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    neovim-nightly-overlay,
    rust-overlay,
    ...
  }: let
    system = "aarch64-darwin";
  in {
    # System (nix-darwin) configurations
    darwinConfigurations = import ./nix/darwin {
      inherit system nix-darwin home-manager nixpkgs;
      neovimOverlay = neovim-nightly-overlay.overlays.default;
      rustOverlay = rust-overlay.overlays.default;
    };

    # Note: Standalone home-manager is not used in this configuration.
    # home-manager is integrated via nix-darwin (see nix/darwin/default.nix:29-34)
  };
}
