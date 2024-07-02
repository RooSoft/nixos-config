{pkgs, ...} : {
  home.packages = with pkgs; [
    # networking
    bandwhich

    #storage
    diskonaut

    # process monitors
    btop
    bottom
    htop
  ];
}
