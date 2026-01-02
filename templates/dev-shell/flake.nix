{
  description = "Simple dev shell with Shino's favrite CLI tools";

  inputs = {
    # reuse nixpkgs from parent flake by default, but allow override
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    # self, # unused
    nixpkgs,
    neovim-nightly-overlay,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [neovim-nightly-overlay.overlays.default];
      config.allowUnfree = true;
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "dev-shell";
      buildInputs = with pkgs; [
        bat
        eza
        fd
        fd
        fzf
        gh
        git
        lazygit
        neovim
        ripgrep

        copilot-language-server
        claude-code
      ];

      shellHook = ''
        echo "Welcome to shino's dev shell ✨"
        echo "Tools: git, nvim, eza, fd, rg, bat"
        nvim --version | head -n 3
      '';
    };
  };
}
