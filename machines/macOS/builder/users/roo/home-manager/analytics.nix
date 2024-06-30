{pkgs, ...} : {
  home.packages = with pkgs; [
    bandwhich
    btop
    diskonaut
    htop
  ];
}
