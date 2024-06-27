{pkgs, ...}: {
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
}
