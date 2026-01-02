{
  pkgs,
  config,  # Available for submodules
  ...
}: {
  imports = [
    ./base.nix
    ./packages.nix
    ./programs.nix
  ];
}
