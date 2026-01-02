{ pkgs, ... }:
# User account management for nix-darwin.
# Defines system users and enables required shells.
let
  userConfig = import ../common.nix;
in {
  # Enable zsh system-wide (required for home-manager zsh configuration)
  programs.zsh.enable = true;

  users.users.${userConfig.username} = {
    name = userConfig.username;
    home = userConfig.homeDirectory;
    # Shell is configured via home-manager (see nix/home/programs.nix)
  };

}
