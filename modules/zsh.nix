{
  ...
}: {
  imports = [
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      ls = "ls --color=auto -F";
    };

    sessionVariables = {
      CLICOLOR = 1;
      EDITOR = "nvim";
    };
  };
}
