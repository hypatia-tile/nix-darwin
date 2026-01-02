{
  system,
  nix-darwin,
  home-manager,
  nixpkgs,
  neovimOverlay,
  rustOverlay,
}: let
  userConfig = import ../common.nix;
  userhome = {
    ${userConfig.username} = import ../home;
  };
in {
  ${userConfig.hostname} = nix-darwin.lib.darwinSystem {
    inherit system;

    modules = [
      ./configuration.nix

      home-manager.darwinModules.home-manager

      {
        # Apply overlays for bleeding-edge tools
        nixpkgs.overlays = [
          neovimOverlay    # Neovim nightly builds
          rustOverlay      # Rust toolchain management
        ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-bak";
          users = userhome;
        };
      }
    ];
  };
}
