{pkgs, ...} : {
  home.packages = with pkgs; [
    fd
    tree
    ripgrep
    minio-client
    less
    unrar-wrapper
    yazi
  ];
}
