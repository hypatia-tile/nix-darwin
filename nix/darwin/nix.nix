{ pkgs, config, lib, ... }:

{
  # Disable nix-darwin's Nix daemon management.
  # Required when using Determinate Systems' Nix installer which manages its own daemon.
  # See: https://determinate.systems/posts/determinate-nix-installer
  nix.enable = false;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = [ "nix-command flakes" ];

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    # Required for unfree packages: VS Code, proprietary fonts, etc.
    config.allowUnfree = true;
  };
}
