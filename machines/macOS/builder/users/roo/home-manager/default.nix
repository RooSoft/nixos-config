{
  pkgs,
  commonFolder,
  ...
}: {
  imports = [
    ./git.nix
    ./filesystem.nix
    ./network.nix
    ./programming
    ./productivity.nix
    ./analytics.nix
    ./security.nix
  ];

  roopkgs.home = {
    zsh.enable = true;
    eza.enable = true;
    helix.enable = true;
    atuin.enable = true;
    tmux.enable = false;
    zellij.enable = true;
    starship.enable = true;
    alacritty.enable = true;
    dust.enable = true;
  };

  home = {
    stateVersion = "22.11";

    packages = with pkgs; [];
  };

  programs = {
    bat.enable = true;
    bat.config.theme = "TwoDark";

    zsh = {
      shellAliases = {
        ls = "ls --color=auto -F";
        update-system = "darwin-rebuild switch --flake /Users/roo/.config/nix/.#";
      };
      envExtra = ''
        export GPG_TTY=$(tty)
        pcd () {cd `pc --name=$1`}
      '';
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };
}
