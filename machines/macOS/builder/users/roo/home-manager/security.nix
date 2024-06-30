{pkgs, ...} : {
  home.packages = with pkgs; [
    libfido2
    yubico-piv-tool
    secp256k1
    gnupg
  ];
}

