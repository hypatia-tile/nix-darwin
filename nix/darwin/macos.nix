{
  pkgs,
  config,
  lib,
  ...
}: let
  userConfig = import ../common.nix;
in {
  # Drop configuration Revision for now to keep it simple
  # (using `self` in an external module requires specialArgs).
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  system.primaryUser = userConfig.username;

  # Homebrew for packages not available in nixpkgs or requiring macOS-specific builds
  homebrew = {
    enable = true;

    casks = [
      "aquaskk" # Japanese input method (not available in nixpkgs)
      "hammerspoon" # Automation and window management
      "nikitabobko/tap/aerospace" # Aerospace is i3-like tiling window manager for macOS
    ];

    # Auto-start Hammerspoon at login
    masApps = {}; # Placeholder for Mac App Store apps
    brews = [
      # Development tools requiring Homebrew's macOS-specific builds
      "llvm" # Used for specific compilation tasks
      "make" # GNU make (supplements system make)
      "cmake" # Build system generator
      "olets/tap/zsh-abbr" # Zsh abbreviation tool
    ];
  };

  ########################################
  # macOS system settings via nix-darwin #
  ########################################
  # Note: macOS defaults are currently managed manually via System Preferences.
  # Uncomment settings below to manage via nix-darwin:

  # Dock settings
  # system.defaults.dock.autohide = true;
  # system.defaults.dock.autohide-delay = 0.0;
  # system.defaults.dock.autohide-time-modifier = 0.15;

  # Keyboard settings - faster key repeat
  # system.defaults.NSGlobalDomain.KeyRepeat = 2;
  # system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;

  # Finder settings
  # system.defaults.finder.AppleShowAllExtensions = true;
  # system.defaults.finder.ShowStatusBar = true;
}
