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

  # networking.extraHosts =
  # ''
  # 192.168.10.1 edgerouter
  # 192.168.10.2 edgeswitch
  # 192.168.88.33 babar
  # 127.0.0.1 ai

  # 192.168.88.10 host01
  # 192.168.88.11 host02
  # 192.168.88.12 host03

  # # 192.168.11.6 roosoft.com
  # 192.168.11.6 git.roosoft.com
  # # 192.168.11.6 wiki.roosoft.com

  # # 192.169.13.5 electrum.roosoft.com

  # 192.168.11.2 astro
  # 192.168.11.3 loki
  # 192.168.11.4 grafana
  # 192.168.11.6 gitea #192.168.11.5
  # 192.168.11.6 dmz
  # 192.168.11.7 wiki
  # 192.168.11.8 homepage
  # 192.168.11.11 mempool
  # 192.168.11.12 electrs
  # 192.168.11.6 mattermost # 192.168.11.13
  # 192.168.11.14 roadWarrior

  # 192.168.12.2 ratel
  # 192.168.12.3 loki-staging
  # 192.168.12.4 grafana-staging
  # 192.168.12.5 gitea-staging
  # 192.168.12.7 wiki-staging
  # 192.168.12.10 minio-staging
  # 192.168.12.13 mattermost-staging

  # 192.168.11.6 test-chat.roosoft.com
  # '';

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

    brews = ["iproute2mac"];

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

    environment = {
      HOST = "0.0.0.0";
      PORT = "8080";
    };

    script = ''
      cd /Users/roo/.config/open-webui/backend
      ${pkgs.bash}/bin/bash start.sh
    '';

    serviceConfig = {
      UserName = "roo";
      KeepAlive = true;
      RunAtLoad = true;
      RootDirectory = "/Users/roo/.config/open-webui/backend";
      StandardOutPath = "/var/log/open-webui.out.log";
      StandardErrorPath = "/var/log/open-webui.err.log";
    };
  };

  nix.extraOptions = ''
    build-users-group = nixbld
    experimental-features = nix-command flakes
  '';
}
