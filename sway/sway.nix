# modules/niri.nix
{
  pkgs,
  config,
  lib,
  ...
}:

{
  # Only enable if Niri is chosen
  config = lib.mkIf config.programs.niri.enable {
    environment.systemPackages = with pkgs; [
      swaysettings
      swayimv
      swaytools
      swayidle
      swaylock
      swaybg
      swayimg
      swayosd
      swaylock-effects
      swaynotificationcenter
      pavucontrol
      slurp
      soteria
    ];
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      # Use mkDefault so it defers to others if they exist
      config.common.default = lib.mkDefault [ "gtk" ];
    };
  };
}
