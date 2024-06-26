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
        }
        {
          key = "ArrowLeft";
          mods = "Command";
          action = "SelectPreviousTab";
        }
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

    window = {
      padding = {
        x = 2;
        y = 4;
      };
    };
  };

  tomlFormat = (pkgs.formats.toml {}).generate "something" config;
in {
  home.file.".config/alacritty/alacritty.toml".source = tomlFormat;
}
