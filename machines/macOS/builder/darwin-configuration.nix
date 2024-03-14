{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [./postgresql.nix];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    rnix-lsp
    tree-sitter
    wireguard-tools

    npins

    inputs.nvim-flake.packages.aarch64-darwin.default

    inputs.project-commander.defaultPackage.aarch64-darwin
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  users.users.roo.home = "/Users/roo";

  homebrew = {
    enable = true;

    brews = [];

    casks = ["wireshark" "1password-cli"];
  };

  launchd.daemons.open-webui = {
    path = [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
      "/Users/roo/.nix-profile/bin"
      "/etc/profiles/per-user/roo/bin"
      "/run/current-system/sw/bin"
      "/nix/var/nix/profiles/default/bin"
      "/usr/local/bin"
      "/usr/bin"
      "/usr/sbin"
      "/bin"
      "/sbin"
    ];

    script = ''
      cd /Users/roo/work/test/openwebui/open-webui/backend
      ${pkgs.bash}/bin/bash start.sh
    '';

    serviceConfig = {
      UserName = "roo";
      KeepAlive = true;
      RunAtLoad = true;
      RootDirectory = "/Users/roo/work/test/openwebui/open-webui/backend";
      StandardOutPath = "/var/log/open-webui.out.log";
      StandardErrorPath = "/var/log/open-webui.err.log";
    };
  };

  nix.extraOptions = ''
    build-users-group = nixbld
    experimental-features = nix-command flakes
  '';
}
