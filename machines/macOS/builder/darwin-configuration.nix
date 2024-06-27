{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./postgresql.nix
    ./open-webui.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    tree-sitter
    wireguard-tools

    inputs.nvim-flake.packages.aarch64-darwin.default
    inputs.project-commander.defaultPackage.aarch64-darwin
  ];

  services.nix-daemon.enable = true;

  programs.zsh = {
    enable = true;
    # autosuggestion.enable = true;  #### NOT WORKING AS OF 24.05
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  users.users.roo.home = "/Users/roo";

  homebrew = {
    enable = true;

    brews = ["iproute2mac"];
    casks = ["wireshark" "1password-cli" "font-meslo-lg-nerd-font"];
  };

  nix.extraOptions = ''
    build-users-group = nixbld
    experimental-features = nix-command flakes
  '';
}
