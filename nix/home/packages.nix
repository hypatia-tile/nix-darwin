{pkgs, ...}: {
  # user-level packages (no sudo):
  home.packages = with pkgs; [
    eza
    fd
    ripgrep
    bat
    fzf
    neovim
    cargo
    rust-analyzer
    rustc
    sqlite
    jq
    vim
    tree
    htop
    deno
    gh
    lazygit
    nodejs_24
    alejandra # Nix code formatter
    statix # Nix linter
    deadnix # Detets unused dependencies in Nix files
    nil # Nix language server
    copilot-language-server
    claude-code
  ];
}
