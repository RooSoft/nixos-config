{pkgs, ...} : {
  home.packages = with pkgs; [
    curl
    xh
    inetutils
    magic-wormhole-rs
    websocat
    miniserve
    nodePackages.http-server
    irssi
  ];
}

