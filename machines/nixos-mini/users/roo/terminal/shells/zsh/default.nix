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

    shellAliases = {
      update-system = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs/.#nixos-mini";
      update-user = "home-manager switch --flake ~/.config/nixpkgs/.#roo@nixos-mini";
      update-flake = "nix flake update ~/.config/nixpkgs/#";
    };
  };
}
