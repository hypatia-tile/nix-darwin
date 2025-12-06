{
  system,
  nix-darwin,
  home-manager,
  neovimOverlay,
  rustOverlay,
}: {
  "Kazukis-MacBook-Air" = nix-darwin.lib.darwinSystem {
    inherit system;

    modules = [
      ./configuration.nix

      home-manager.darwinModules.home-manager

      {
        # apply neovim
        nixpkgs.overlays = [
          neovimOverlay
          rustOverlay
        ];

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-bak";

        home-manager.users.kazukishinohara =
          import ../home/default.nix;
      }
    ];
  };
}
