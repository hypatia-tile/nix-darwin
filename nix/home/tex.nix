{pkgs, ...}: {
  # Install TeX Live into user environment
  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
