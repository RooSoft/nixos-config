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

  starshipModulePath = modulesFolder + "/starship.nix";
  zshModulePath = modulesFolder + "/zsh.nix";
in {
  imports = [
    ../../../../../../common/modules/eza.nix
    ../../../../../../common/modules/zellij
    starshipModulePath
    zshModulePath
    ./helix
    ./atuin.nix
    ./alacritty
  ];

  home = {
    stateVersion = "22.11";

    packages = with pkgs;
      (import defaultHomePackagesPath {pkgs = pkgs;})
      ++ [
        nixfmt
        fd
        xh
        inetutils
        btop
        fzf
        tldr
        magic-wormhole-rs
        gh

        taskwarrior
        diskonaut
        bandwhich

        nodejs_20
        unstable.erlang
        unstable.elixir
        unstable.elixir_ls
        rnix-lsp
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

        helix
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
        e = "eza -lg --git --git-repos";
      };
      envExtra = ''
        export GPG_TTY=$(tty)
        pcd () {cd `pc --name=$1`}
        eval "$(zoxide init zsh)"
      '';
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        bindkey "\e[3~" delete-char
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
