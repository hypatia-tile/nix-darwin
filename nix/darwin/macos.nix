{...}: {
  # Drop ocnfiguration Revision for now to keep it simple
  # (using `self` in an external module requires specialArgs).
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  system.primaryUser = "kazukishinohara";

  homebrew = {
    enable = true;

    casks = [
      "aquaskk"
    ];
    brews = [
      "llvm"
      "make"
      "cmake"
    ];
  };

  ########################################
  # macOS system settings via nix-darwin #
  ########################################
  # Make Dock auto-hide and speed it up
  # system.defaults.dock.autohide = true;
  # system.defaults.dock.autohide-delay = 0.0;
  # system.defaults.dock.autohide-time-modifier = 0.15;

  # Faster key repeat (you can tweak these)
  # system.defaults.NSGlobalDomain.KeyRepeat = 2;
  # system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;

  # Finder: show all filename extensions
  # system.defaults.finder.AppleShowAllExtensions = true;

  # (optional) Finder: show status bar
  # system.defaults.finder.ShowStatusBar = true;
}
