{
  pkgs,
  unstable,
  lib,
  commonFolder,
  inputs,
  ...
}: let
  defaultHomePackagesPath = commonFolder + "/defaultHomePackages.nix";

  modulesFolder = commonFolder + "/modules";

  zshModulePath = modulesFolder + "/zsh.nix";
in {
  imports = [
    zshModulePath
    ./git.nix
    ./alacritty
  ];

  roopkgs.home = {
    eza.enable = true;
    helix.enable = true;
    atuin.enable = true;
    zellij.enable = true;
    starship.enable = true;
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

        zoxide

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
        eval "$(zoxide init zsh)"
      '';
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # see https://superuser.com/a/169930/109556
        bindkey "\e[3~" delete-char
        bindkey "\e[F" forward-word
        bindkey "\e[H" backward-word
      '';
    };

    tmux = {
      enable = true;
      customPaneNavigationAndResize = true;
      keyMode = "vi";
      terminal = "screen-256color";
      extraConfig = ''
        set -g mouse on

        set-option -sg escape-time 10
        set-option -g focus-events on
        set-option -sa terminal-overrides ',xterm-256color:RGB'
      '';
    };
  };
}
