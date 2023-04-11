{ lib, config, pkgs, inputs, ... }:

let
  unstable = import <nixos-unstable> {};

in
  {
    imports = [
      inputs.neovim-flake.homeManagerModules.default
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

    programs.zsh = {
      enable = true;
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

    programs.neovim-flake = {
      enable = true;

      settings = {
        vim.viAlias = false;
        vim.vimAlias = true;
        vim.lsp = {
          enable = true;
        };
      };
    };
  }
