{ pkgs, ... }:

{
  # 1. Core Network Stack
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      # Declarative VPN profiles for quick switching
      ensureProfiles.profiles = {
        "Nord-Brisbane" = {
          connection = {
            id = "Nord-Brisbane";
            type = "vpn";
            autoconnect = false;
          };
          vpn = {
            type = "org.freedesktop.NetworkManager.wireguard";
          };
        };
        "Nord-Sydney" = {
          connection = {
            id = "Nord-Sydney";
            type = "vpn";
            autoconnect = false;
          };
          vpn = {
            type = "org.freedesktop.NetworkManager.wireguard";
          };
        };
        "Nord-Auckland" = {
          connection = {
            id = "Nord-Auckland";
            type = "vpn";
            autoconnect = false;
          };
          vpn = {
            type = "org.freedesktop.NetworkManager.wireguard";
          };
        };
      };
    };

    firewall = {
      enable = true;
      checkReversePath = "loose";
      allowedUDPPorts = [ 51820 ];
    };
  };

  # 2. Networking Tools
  environment.systemPackages = with pkgs; [
    wireguard-tools
    networkmanager
  ];
}
