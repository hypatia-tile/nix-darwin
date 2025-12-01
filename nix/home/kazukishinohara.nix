{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./base.nix
    ./packages.nix
    ./programs.nix
    ./tex.nix
  ];
}
