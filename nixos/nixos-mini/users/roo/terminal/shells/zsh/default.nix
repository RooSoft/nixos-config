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
      update-system = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs/.#nixos-mini";
      update-user = "home-manager switch --flake ~/.config/nixpkgs/.#roo@nixos-mini";
      update-flake = "nix flake update ~/.config/nixpkgs/#";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };
}
