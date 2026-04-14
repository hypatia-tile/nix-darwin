{
  pkgs,
  config,
  ...
}: let
  userConfig = import ../common.nix;
in {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    # Tmux: managed in dotfiles, installed as package (see packages.nix)
    # Note: programs.tmux is disabled to avoid home-manager generating config files

    # Alacritty: managed in dotfiles, installed as package (see packages.nix)
    # Note: programs.alacritty is disabled to avoid home-manager generating config files

    # Kitty: managed in dotfiles, installed as package (see packages.nix)
    # Note: programs.kitty is disabled to avoid home-manager generating config files

    # example: enable some HM-managed programs
    git = {
      enable = false;
    };
    # Zsh: managed in dotfiles, symlinked via dot-link.sh
    # Configuration files: ~/github/dotfiles/.config/zsh/
    # Note: programs.zsh is disabled to avoid home-manager generating config files
    # Zsh is still enabled system-wide in nix/darwin/users.nix for shell compatibility
    zsh.enable = false;

    home-manager.enable = true;
  };
}
