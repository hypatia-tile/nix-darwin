{config, ...}: let
  userConfig = import ../common.nix;
in {
  home.username = userConfig.username;
  home.homeDirectory = userConfig.homeDirectory;
  # Set on initial configuration: 2026-01-02
  # Do not change unless migrating or reinstalling
  home.stateVersion = "25.05";
  home.sessionPath = [
    "${userConfig.homeDirectory}/.nix-profile/bin"
    "/etc/profiles/per-user/${userConfig.username}/bin"
    "/run/current-system/sw/bin"
    "/opt/homebrew/opt/llvm/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/nix/var/nix/profiles/default/bin"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.enable = true;

  # Hammerspoon configuration for window management and Kitty integration
  home.file.".hammerspoon/init.lua".text = ''
    -- Hammerspoon configuration managed by nix-darwin
    -- Kitty terminal integration and window management

    -- ===== Kitty Terminal Integration =====

    -- Launch or focus Kitty with Cmd+Alt+K
    hs.hotkey.bind({"cmd", "alt"}, "K", function()
      local kitty = hs.application.find("kitty")
      if kitty then
        kitty:activate()
      else
        hs.application.open("kitty")
      end
    end)

    -- ===== Window Management =====

    -- Move window to left half
    hs.hotkey.bind({"cmd", "alt"}, "Left", function()
      local win = hs.window.focusedWindow()
      if win then
        win:moveToUnit(hs.geometry.rect(0, 0, 0.5, 1))
      end
    end)

    -- Move window to right half
    hs.hotkey.bind({"cmd", "alt"}, "Right", function()
      local win = hs.window.focusedWindow()
      if win then
        win:moveToUnit(hs.geometry.rect(0.5, 0, 0.5, 1))
      end
    end)

    -- Move window to top half
    hs.hotkey.bind({"cmd", "alt"}, "Up", function()
      local win = hs.window.focusedWindow()
      if win then
        win:moveToUnit(hs.geometry.rect(0, 0, 1, 0.5))
      end
    end)

    -- Move window to bottom half
    hs.hotkey.bind({"cmd", "alt"}, "Down", function()
      local win = hs.window.focusedWindow()
      if win then
        win:moveToUnit(hs.geometry.rect(0, 0.5, 1, 0.5))
      end
    end)

    -- Maximize window
    hs.hotkey.bind({"cmd", "alt"}, "M", function()
      local win = hs.window.focusedWindow()
      if win then
        win:maximize()
      end
    end)

    -- Center window
    hs.hotkey.bind({"cmd", "alt"}, "C", function()
      local win = hs.window.focusedWindow()
      if win then
        win:centerOnScreen()
      end
    end)

    -- ===== Display Management =====

    -- Move window to next display
    hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
      local win = hs.window.focusedWindow()
      if win then
        win:moveToScreen(win:screen():next())
      end
    end)

    -- Move window to previous display
    hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
      local win = hs.window.focusedWindow()
      if win then
        win:moveToScreen(win:screen():previous())
      end
    end)

    -- ===== Configuration Reload =====

    -- Reload Hammerspoon config with Cmd+Alt+R
    hs.hotkey.bind({"cmd", "alt"}, "R", function()
      hs.reload()
    end)
    hs.alert.show("Hammerspoon config loaded")
  '';

  # Auto-start Hammerspoon at login
  launchd.agents.hammerspoon = {
    enable = true;
    config = {
      ProgramArguments = [ "/Applications/Hammerspoon.app/Contents/MacOS/Hammerspoon" ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  programs.home-manager.enable = true;
}
