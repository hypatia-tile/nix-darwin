{pkgs, ...}: {
  # User-level packages (no sudo required).
  # See ADR 0002 for separation of concerns between darwin and home-manager.
  home.packages = with pkgs; [
    # Terminal emulators and multiplexers
    # Configurations managed in ~/github/dotfiles/.config/
    alacritty
    kitty
    tmux

    # Shell utilities
    eza
    fd
    ripgrep
    bat
    fzf
    tree
    htop
    jq
    sqlite

    # Editors
    neovim
    vim

    # Development tools
    cargo
    rust-analyzer
    rustc
    deno
    gh
    lazygit
    nodejs_24
    typescript-language-server

    # Nix tools
    alejandra # Nix code formatter
    statix # Nix linter
    deadnix # Detects unused dependencies in Nix files
    nil # Nix language server

    # Language servers
    vim-language-server
    bash-language-server
    lua-language-server

    # AI coding assistants
    copilot-language-server
    claude-code

    # TeX/LaTeX environment
    texlive.combined.scheme-full
  ];
}
