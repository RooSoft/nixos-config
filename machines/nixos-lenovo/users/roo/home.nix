{
  lib,
  config,
  pkgs,
  inputs,
  modulesFolder,
  ...
}: {
  imports = let
    starshipModulePath = modulesFolder + "/starship.nix";
  in [
    ./terminal/shells/zsh
    starshipModulePath
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "22.11";
    username = "roo";
    homeDirectory = /home/roo;
    packages = with pkgs; [
      htop
      tmux
      nodejs-16_x
      bash
      unrar-wrapper
      elixir_1_14
      elixir_ls
      rnix-lsp
      inputs.neovim-flake.packages.x86_64-linux
    ];
  };
}
