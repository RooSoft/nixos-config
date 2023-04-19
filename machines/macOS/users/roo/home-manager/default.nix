# options docs found here: https://nix-community.github.io/home-manager/options.html

{ pkgs, lib, ... } : 
{
  home = {
    stateVersion = "22.11";

    packages = with pkgs; [
      ripgrep
        curl
        less
    ];

    sessionVariables = {
      SPACESHIP_HOST_SHOW = "always";
      SPACESHIP_USER_SHOW = "always";
      SPACESHIP_TIME_SHOW = "always";
    };
  };

  programs = {
    bat.enable = true;
    bat.config.theme = "TwoDark";

    zsh = {
      enable = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      shellAliases = {
        ls = "ls --color=auto -F"; 
        update-system = "darwin-rebuild switch --flake /Users/roo/.config/nix/.#";
      };
      sessionVariables = {
        CLICOLOR = 1;
        EDITOR = "nvim";
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        palette = "foo";

        palettes.foo = {
          mustard = "#af8700";
          turquoise = "#156760";
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

        git_metrics.disabled = false;
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
    };
  };
}

