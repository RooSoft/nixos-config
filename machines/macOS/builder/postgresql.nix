{
  pkgs,
  ...
}: {
  # documentation about running postgresql on a mac with the nix package manager
  # https://mgdm.net/weblog/postgresql-in-a-nix-shell/

  # create the postgres user with this command:
  #   create role postgres with superuser login password 'postgres';
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
    dataDir = "/usr/local/var/postgres/data";
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
  };

  system.activationScripts.preActivation = {
    enable = true;
    text = ''
      if [ ! -d "/var/lib/postgresql/" ]; then
        echo "creating PostgreSQL data directory..."
        sudo mkdir -m 775 -p /usr/local/var/postgres
        chown -R roo:staff /usr/local/var/postgres
      fi
    '';
  };

  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "/Users/roo/.local/share/postgresql/postgres.error.log";
    StandardOutPath = "/Users/roo/.local/share/postgresql/postgres.out.log";
  };
}
