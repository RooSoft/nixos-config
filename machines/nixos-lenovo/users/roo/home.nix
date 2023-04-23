{ lib, pkgs, inputs, commonFolder, ... }:
let
  defaultHomePackagesPath = commonFolder + "/defaultHomePackages.nix";

  modulesFolder = commonFolder + "/modules";

  starshipModulePath = modulesFolder + "/starship.nix";
  zshModulePath = modulesFolder + "/zsh.nix";
in
{
  imports = [
    zshModulePath
    starshipModulePath
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "22.11";
    username = "roo";
    homeDirectory = /home/roo;
    packages = with pkgs; (import defaultHomePackagesPath { pkgs = pkgs; }) ++ [
      nodejs-16_x
      elixir_1_14
      elixir_ls
      rebar3
      rnix-lsp
      postgresql_15
      inputs.neovim-flake.packages.x86_64-linux
    ];
  };

  programs.zsh = {
    shellAliases = {
      update-system = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs/.#nixos-lenovo";
      update-user = "home-manager switch --flake ~/.config/nixpkgs/.#roo@nixos-lenovo";
      update-flake = "nix flake update ~/.config/nixpkgs/#";
    };
  };
}
