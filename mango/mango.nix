{
  pkgs,
  config,
  lib,
  ...
}:

{
  # Only apply this if you have a specific way of enabling MangoWM,
  # or simply ensure this module is imported only when using MangoWM.

  environment.systemPackages = with pkgs; [
    slurp
    mako
    gtklock
    wpaperd
    pavucontrol
    soteria # Add the package here
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
