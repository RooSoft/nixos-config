{
  pkgs,
  unstable,
  ...
}: let
  # see https://alacritty.org/config-alacritty.html
  config = {
    font = {
      normal = {
        family = "MesloLGM Nerd Font Mono";
      };
      size = 13;
      offset = {
        y = -4;
      };
    };

    keyboard = {
      bindings = [
        {
          key = "ArrowRight";
          mods = "Command";
          action = "SelectNextTab";
        } # select next tab
        {
          key = "ArrowLeft";
          mods = "Command";
          action = "SelectPreviousTab";
        } # select previous tab
      ];
    };

    colors = {
      primary = {
        foreground = "#c0cbf2";
        background = "#24283a";
      };
      selection = {
        foreground = "#111111";
        background = "#90ccfa";
      };
    };
  };

  tomlFormat = (pkgs.formats.toml {}).generate "something" config;
in {
  home.file.".config/alacritty/alacritty.toml".source = tomlFormat;
}
