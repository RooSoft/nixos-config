{ lib, ... } : 
{
  enable = true;
  enableZshIntegration = true;

  settings = {
    palette = "foo";

    palettes.foo = {
      mustard = "#af8700";
      turquoise = "#156760";
      deleted = "#903030";
      added = "#106010";
    };

    fill.symbol = " ";

    username = {
      show_always = true;
      style_user = "turquoise bold";
      style_root = "bright-red bold";
      format = "[$user]($style)";
    };

    hostname = {
      ssh_only = false;
      ssh_symbol = " 📞";
      style = "turquoise bold";
      format = "@[$hostname]($style)$ssh_symbol ";
    };

    directory = {
      truncation_length = 3;
      truncate_to_repo = false;
      format = "[$read_only]($read_only_style)[$path]($style) ";
      read_only = "🔒 ";
    };

    git_metrics = {
      disabled = false;
      added_style = "added bold";
      deleted_style = "deleted bold";
    };

    git_status.style = "";

    time = {
      disabled = false;
      format = "[$time]($style)";
    };

    cmd_duration = {
      style = "mustard bold";
    };

    jobs = {
      format = "[$number$symbol]($style)";
      symbol = "⚙ ";
      style = "mustard bold";
    };

    format = let
      who = [
      "$username" 
        "$hostname"
        "$directory"
      ];

    git = [
      "$git_branch"
        "$git_state"
        "$git_status"
        "$git_metrics"
    ];

    fill = [ "$fill" ];

    duration = [
      "$cmd_duration"
    ];

    time = [
      "$jobs"
        "$time"
    ];

    languages = [
      "$nix_shell"
        "$nodejs"
        "$elixir"
    ];

    prompt = [ 
      "$line_break"
      "❯ " 
    ];
    in lib.concatStrings(who ++ git ++ fill ++ duration ++ languages ++ time ++ prompt);
  };
}
