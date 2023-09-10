{ config, pkgs, ... }:
{
  # documentation about running postgresql on a mac with the nix package manager
  # https://mgdm.net/weblog/postgresql-in-a-nix-shell/

  # create the postgres user with this command:
  #   create role postgres with superuser login password 'postgres';
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
  };
}

