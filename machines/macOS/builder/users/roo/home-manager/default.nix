{
  pkgs,
  unstable,
  lib,
  commonFolder,
  inputs,
  ...
}: let
  defaultHomePackagesPath = commonFolder + "/defaultHomePackages.nix";
in {
  imports = [
    ./git.nix
  ];

  roopkgs.home = {
    zsh.enable = true;
    eza.enable = true;
    helix.enable = true;
    atuin.enable = true;
    tmux.enable = false;
    zellij.enable = true;
    starship.enable = true;
    alacritty.enable = true;
  };

  home = {
    stateVersion = "22.11";

    packages = with pkgs;
      (import defaultHomePackagesPath {pkgs = pkgs;})
      ++ [
        fd
        xh
        inetutils
        btop
        fzf
        tldr
        magic-wormhole-rs
        gh
        delta

        taskwarrior
        diskonaut
        bandwhich

        nodejs_20
        unstable.erlang
        unstable.elixir
        unstable.elixir_ls
        pinentry_mac
        libfido2
        yubico-piv-tool

        unstable.rustc
        unstable.cargo
        unstable.cargo-watch
        unstable.cargo-generate
        unstable.cargo-nextest
        unstable.rust-analyzer
        unstable.rustfmt
        unstable.clippy
        unstable.just
        secp256k1
        iconv
        websocat
        qrencode
        zbar
        nodePackages.http-server
        wasm-pack

        lazygit

        alejandra
        lldb

        miniserve

        flyctl

        irssi

        minio-client
      ];
  };

  programs = {
    bat.enable = true;
    bat.config.theme = "TwoDark";

    zsh = {
      shellAliases = {
        ls = "ls --color=auto -F";
        update-system = "darwin-rebuild switch --flake /Users/roo/.config/nix/.#";
      };
      envExtra = ''
        export GPG_TTY=$(tty)
        pcd () {cd `pc --name=$1`}
      '';
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # see https://superuser.com/a/169930/109556
        bindkey "\e[3~" delete-char
        bindkey "\e[F" forward-word
        bindkey "\e[H" backward-word
      '';
    };
  };
}
