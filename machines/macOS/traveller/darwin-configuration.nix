{
  pkgs,
  inputs,
  ...
}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
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

    brews = ["iproute2mac"];
    casks = ["wireshark" "1password-cli" "font-meslo-lg-nerd-font" "alacritty"];
  };

  nix.extraOptions = ''
    build-users-group = nixbld
    experimental-features = nix-command flakes
  '';
}
