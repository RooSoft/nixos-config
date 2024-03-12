{...}: {
  imports = [
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "ls --color=auto -F";
    };

    sessionVariables = {
      CLICOLOR = 1;
      EDITOR = "hx";
    };
  };
}
