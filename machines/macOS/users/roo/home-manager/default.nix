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
    in
    [
      starshipModulePath
    ];

  programs =
    {
      bat.enable = true;
      bat.config.theme = "TwoDark";

      zsh = {
        enable = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        shellAliases = {
          ls = "ls --color=auto -F";
          update-system = "darwin-rebuild switch --flake /Users/roo/.config/nix/.#";
        };
        sessionVariables = {
          CLICOLOR = 1;
          EDITOR = "nvim";
        };
      };
    };
}

