{pkgs, ...} : {
  imports = [
    ./elixir.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    gh
    jq
    delta
    just
    iconv
    lazygit
    qrencode
    zbar
    wasm-pack
    lldb
    nodejs_20
    flyctl
    alejandra
  ];
}


