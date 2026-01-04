{
  pkgs,
  config,
  ...
}: let
  userConfig = import ../common.nix;
in {
  # Create git commit template file
  xdg.configFile."git/commit_template.txt".text = ''
    # <type>: <subject> (50 chars max)

    # <body> - Explain what and why, not how (wrap at 72 chars)

    # Type: feat, fix, docs, style, refactor, test, chore
  '';

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
      enable = true;
      userName = userConfig.gitUserName;
      userEmail = userConfig.gitUserEmail;
      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "nvim";
        commit.template = "${config.xdg.configHome}/git/commit_template.txt";
      };
    };
    # Zsh: managed in dotfiles, symlinked via dot-link.sh
    # Configuration files: ~/github/dotfiles/.config/zsh/
    # Note: programs.zsh is disabled to avoid home-manager generating config files
    # Zsh is still enabled system-wide in nix/darwin/users.nix for shell compatibility
    zsh.enable = false;

    home-manager.enable = true;
  };
}
