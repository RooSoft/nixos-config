# options docs found here: https://nix-community.github.io/home-manager/options.html

{ pkgs, lib, ... } : 
{
  home = {
    stateVersion = "22.11";

    packages = with pkgs; [
      ripgrep
        curl
        less
    ];
  };

  programs = {
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

    starship = import ./starship.nix { lib = lib; };

  };
}

