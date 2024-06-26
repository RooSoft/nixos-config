{
  lib,
  pkgs,
  inputs,
  commonFolder,
  ...
}: let
  defaultHomePackagesPath = commonFolder + "/defaultHomePackages.nix";

  modulesFolder = commonFolder + "/modules";

  starshipModulePath = modulesFolder + "/starship.nix";
  zshModulePath = modulesFolder + "/zsh.nix";
in {
  imports = [
    zshModulePath
    starshipModulePath
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "22.11";
    username = "roo";
    homeDirectory = /home/roo;
    packages = with pkgs;
      (import defaultHomePackagesPath {pkgs = pkgs;})
      ++ [
        nodejs-16_x
        elixir_1_14
        elixir_ls
        rnix-lsp
        inputs.neovim-flake.packages.x86_64-linux
        inotify-tools
      ];
  };

  programs.zsh = {
    shellAliases = {
      update-system = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs/.#nixos-mini";
      update-user = "home-manager switch --flake ~/.config/nixpkgs/.#roo@nixos-mini";
      update-flake = "nix flake update ~/.config/nixpkgs/#";
    };
  };
}
