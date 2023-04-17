{
  lib,
  config,
  pkgs,
  pkgs_unstable,
  inputs,
  ...
}: {
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
      pkgs_unstable.elixir_1_14
      pkgs_unstable.elixir_ls
    ];
  };
}
