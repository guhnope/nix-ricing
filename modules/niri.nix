# modules/niri.nix
{ pkgs, ... }:

{

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    slurp
    cliphist
    mako
    gtklock
    sway-contrib.grimshot
  ];
}
