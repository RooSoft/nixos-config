{ lib
, config
, pkgs
, inputs
, modulesFolder
, ...
}: {
  imports =
    let
      starshipModulePath = modulesFolder + "/starship.nix";
      zshModulePath = modulesFolder + "/zsh.nix";
    in
    [
      zshModulePath
      starshipModulePath
    ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh = {
    shellAliases = {
      update-system = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs/.#nixos-lenovo";
      update-user = "home-manager switch --flake ~/.config/nixpkgs/.#roo@nixos-lenovo";
      update-flake = "nix flake update ~/.config/nixpkgs/#";
    };
  };

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
