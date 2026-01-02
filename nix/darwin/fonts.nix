{ pkgs, ... }:
# System-wide font configuration for nix-darwin.
# Installs Nerd Fonts for terminal and development use.
{
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
