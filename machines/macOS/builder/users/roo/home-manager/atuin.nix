{config, ...}: {
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = false;
      update_check = false;
      filter_mode = "directory";
      ctrl_n_shortcuts = true;
      enter_accept = true;

      stats = {
        common_subcommands = [
          "cargo"
          "docker"
          "git"
          "ip"
          "nix"
          "npm"
          "systemctl"
        ];

        common_prefix = ["sudo"];
      };
    };
  };
}
