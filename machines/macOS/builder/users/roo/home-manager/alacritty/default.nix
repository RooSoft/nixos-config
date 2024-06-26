{
  pkgs,
  unstable,
  ...
}: let
  config = {
    font = {
      normal = {
        family = "MesloLGM Nerd Font Mono";
      };
      size = 13;
    };

    keyboard = {
      bindings = [
        {
          key = "ArrowRight";
          mods = "Command";
          chars = "\x02n";
        } # select next tab
        {
          key = "ArrowLeft";
          mods = "Command";
          chars = "\x02p";
        } # select previous tab
      ];
    };
  };

  tomlFormat = (pkgs.formats.toml {}).generate "something" config;
in {
  home.file.".config/alacritty/alacritty.toml".source = tomlFormat;
}
