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

  programs.home-manager.enable = true;
}
