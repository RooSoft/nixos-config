{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      update-system = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs/.#nixos-lenovo";
      update-user = "home-manager switch --flake ~/.config/nixpkgs/.#roo@nixos-lenovo";
      update-flake = "nix flake update ~/.config/nixpkgs/#";
    };
  };
}
