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
    zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
        }
      ];
      enableCompletion = true;

      # Body of ~/.zshrc
      initExtra = ''
        autoload -Uz vcs_info
        precmd() { vcs_info }

        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:git:*' formats '(%b)'
        zstyle ':vcs_info:git:*' actionformats '(%b|%a)'
        setopt autocd
        setopt correct
        setopt interactivecomments
        setopt share_history
        setopt prompt_subst
        PROMPT='%F{cyan}%n%f@%m %F{yellow}%1~%f ''${vcs_info_msg_0_} %# '
        bindkey -v
        alias ll='ls -lah'
      '';

      # History behavior
      history = {
        size = 10000;
        save = 10000;
        share = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config.xdg.dataHome}/zsh/history";
      };
    };

    home-manager.enable = true;
  };
}
