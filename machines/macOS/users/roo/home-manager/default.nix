{ pkgs, lib, commonFolder, ... }:
let
  defaultHomePackagesPath = commonFolder + "/defaultHomePackages.nix";

  modulesFolder = commonFolder + "/modules";

  starshipModulePath = modulesFolder + "/starship.nix";
  zshModulePath = modulesFolder + "/zsh.nix";
in
{
  imports =
    [
      starshipModulePath
      zshModulePath
    ];

  home = {
    stateVersion = "22.11";

    packages = with pkgs; (import defaultHomePackagesPath { pkgs = pkgs; }) ++ [
      nodejs-16_x
      elixir_1_14
      elixir_ls
      rnix-lsp
      pinentry_mac
      libfido2
      yubico-piv-tool
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
    };
  };
}

