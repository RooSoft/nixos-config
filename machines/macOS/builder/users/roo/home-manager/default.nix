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

    packages = with pkgs; [
        # filesystem
        fd
        tree
        ripgrep
        minio-client
        less
        unrar-wrapper

        # network
        curl
        xh
        inetutils
        magic-wormhole-rs
        websocat
        miniserve
        nodePackages.http-server
        irssi

        # programming
        gh
        jq
        delta

        # productivity
        tldr
        taskwarrior

        # analytics
        bandwhich
        btop
        diskonaut
        htop

        # programming
        unstable.just
        iconv
        lazygit
        qrencode
        zbar
        wasm-pack
        lldb
        nodejs_20
        flyctl

        # nix
        alejandra

        # elixir
        unstable.erlang
        unstable.elixir
        unstable.elixir_ls

        # rust
        unstable.rustc
        unstable.cargo
        unstable.cargo-watch
        unstable.cargo-generate
        unstable.cargo-nextest
        unstable.rust-analyzer
        unstable.rustfmt
        unstable.clippy

        # security
        libfido2
        yubico-piv-tool
        secp256k1
        gnupg
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
