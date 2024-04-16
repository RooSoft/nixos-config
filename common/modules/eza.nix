{ pkgs, ... } :
{
  home.shellAliases = {
    l = "eza -l --git";
  };

  home = {
    packages = with pkgs;
      [
        eza
      ];
  };
}
