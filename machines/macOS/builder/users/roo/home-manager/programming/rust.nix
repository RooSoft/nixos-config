{unstable, ...} : {
  home.packages = with unstable; [
    rustc
    cargo
    cargo-watch
    cargo-generate
    cargo-nextest
    rust-analyzer
    rustfmt
    clippy
  ];
}

