{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  unstable = import <nixos-unstable> {};
in {
  imports = [
    ./terminal/editors/neovim
    ./terminal/shells/zsh
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
    ];
  };
}
