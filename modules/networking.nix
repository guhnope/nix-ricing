{ pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
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
  environment.systemPackages = with pkgs; [
    wireguard-tools
    networkmanager
  ];
}
