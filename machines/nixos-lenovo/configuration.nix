# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos-lenovo";

  # Set your time zone.
  time.timeZone = "America/Toronto";

  users.users.roo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = [
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    ack
    git
    jq
    home-manager
    zsh
    nix-tree
    lf
    ripgrep
    bat
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  #  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
    permitRootLogin = "yes";
  };

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    port = 5432;
    package = pkgs.postgresql_15;

    ensureDatabases = [ "roo" ];
    ensureUsers = [{
      name = "roo";
    }];

    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE roo WITH LOGIN PASSWORD 'roo' CREATEDB;
      CREATE DATABASE roo;
      GRANT ALL PRIVILEGES ON DATABASE roo TO roo;
    '';
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 443 ];
  networking.firewall.allowedUDPPorts = [ ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

