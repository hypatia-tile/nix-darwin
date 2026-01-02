{ pkgs, ... }:
# Main configuration aggregator for nix-darwin system-level settings.
# This module imports all darwin domain-specific configurations.
{
  imports = [
    ./nix.nix      # Nix daemon and build settings
    ./users.nix    # User account management
    ./fonts.nix    # System-wide font installation
    ./macos.nix    # macOS system preferences and settings
  ];
}
