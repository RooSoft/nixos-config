{ pkgs, ... } : {
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

  programs = {
    bat.enable = true;
    bat.config.theme = "TwoDark";
  };
}
