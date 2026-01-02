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
    tmux = {
      enable = true;
      # Use zsh as the default shell inside tmux
      shell = "${pkgs.zsh}/bin/zsh";
      # Nice default
      mouse = true;
      baseIndex = 1;
      clock24 = true;
      historyLimit = 10000;
      # Recommended: fast, responsive escape-time
      escapeTime = 10;
      extraConfig = ''
        vim_pattern='(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?'
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +''${vim_pattern}$'"
        set -g status-style "bg=colour236 fg=white"
        set -g pane-border-style "fg=colour238"
        set -g pane-active-border-style "fg=colour39"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l
        unbind C-b
        set -g prefix C-q
        bind-key -n M-Up resize-pane -U 3
        bind-key -n M-Down resize-pane -D 3
        bind-key -n M-Left resize-pane -L 3
        bind-key -n M-Right resize-pane -R 3
      '';
    };

    alacritty = {
      enable = true;
      # This writes TOML/YAML config to $XDG_CONFIG_HOME/alacritty/alacritty.toml
      # as documented in Home Manager.
      settings = {
        env = {
          TERM = "xterm-256color";
        };
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          size = 11.0;
        };
        colors = {
          primary = {
            background = "0x282c34";
            foreground = "0xabb2bf";
          };
          cursor = {
            text = "0x282c34";
            cursor = "0x528bff";
          };
          normal = {
            black = "0x282c34";
            red = "0xe06c75";
            green = "0x98c379";
            yellow = "0xe5c07b";
            blue = "0x61afef";
            magenta = "0xc678dd";
            cyan = "0x56b6c2";
            white = "0xabb2bf";
          };
        };

        window = {
          padding = {
            x = 10;
            y = 10;
          };
          dynamic_padding = true;
          decorations = "Buttonless";
          opacity = 0.75;
          blur = false;
          startup_mode = "Windowed";
        };

        scrolling = {
          history = 100000;
          multiplier = 3;
        };
      };
    };

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
