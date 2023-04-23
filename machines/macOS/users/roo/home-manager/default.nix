# options docs found here: https://nix-community.github.io/home-manager/options.html

{ pkgs, lib, modulesFolder, ... }:
{
  home = {
    stateVersion = "22.11";

    packages = with pkgs; [
      ripgrep
      curl
      less
      htop
      tmux
      nodejs-16_x
      bash
      unrar-wrapper
      elixir_1_14
      elixir_ls
      rnix-lsp
    ];
  };

  imports =
    let
      starshipModulePath = modulesFolder + "/starship.nix";
      zshModulePath = modulesFolder + "/zsh.nix";
    in
    [
      starshipModulePath
      zshModulePath
    ];

  programs =
    {
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

