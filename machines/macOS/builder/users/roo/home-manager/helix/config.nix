{
  pkgs,
  unstable,
  ...
}: let
  package = unstable.helix;

  config = {
    # theme = "jellybeans";
    theme = "catppuccin_macchiato";

    editor = {
      true-color = true;
      line-number = "relative";
      mouse = true;

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      file-picker = {
        hidden = false;
      };

      lsp = {
        display-messages = true;
      };

      statusline = {
        right = ["diagnostics" "position" "position-percentage" "file-encoding" "file-type"];
      };
    };

    keys = {
      normal = {
        C-j = ["extend_to_line_bounds" "delete_selection" "paste_after"];
        C-k = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"];
      };
    };
  };

  tomlFormat = (pkgs.formats.toml {}).generate "something" config;
in {
  home.file.".config/helix/config.toml".source = tomlFormat;
}
