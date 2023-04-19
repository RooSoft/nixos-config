{ pkgs, ... } : {
  # options docs found here: https://nix-community.github.io/home-manager/options.html
  home = {
    stateVersion = "22.11";

    packages = with pkgs; [
      ripgrep
      curl
      less
    ];

    sessionVariables = {
      CLICOLOR = 1;
      EDITOR = "nvim";
    };
  };

  home.sessionVariables.TEST = 43;

  programs = {
    bat.enable = true;
    bat.config.theme = "TwoDark";

    zsh = {
      enable = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      shellAliases = {
        ls = "ls --color=auto -F"; 
      };
      sessionVariables = {
        TEST = 33;
      };
    };

    starship.enable = true;
    starship.enableZshIntegration = true;
  };
}
