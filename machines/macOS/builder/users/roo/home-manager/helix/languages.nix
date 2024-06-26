{pkgs, ...}: let
  config = {
    language = [
      {
        name = "elixir";
        scope = "source.elixir";
        injection-regex = "elixir";
        file-types = ["ex" "exs"];
        roots = ["mix.exs"];
        auto-format = true;
        diagnostic-severity = "Hint";
        comment-token = "#";
        indent = {
          tab-width = 2;
          unit = " ";
        };
        language-servers = ["elixir-ls"];
      }
    ];
  };

  tomlFormat = (pkgs.formats.toml {}).generate "something" config;
in {
  home.file.".config/helix/languages.toml".source = tomlFormat;
}
