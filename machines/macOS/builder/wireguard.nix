{ ... }: {
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = ["10.10.0.2/24"];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51820;

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/Users/roo/.config/wireguard/private";

      peers = [
        {
          # builder
          publicKey = "ZoZlaSqi4sjk9auVxFPBAgw4p7UPF/8zAW6Aq2lzehE=";

          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = ["192.168.10.100/32"];

          # Server IP and port.
          endpoint = ["170.187.182.8/32"];

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
