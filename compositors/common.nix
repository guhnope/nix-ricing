{
  pkgs,
  lib,
  activeTheme,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wlogout
    matugen
    grim
    awww
    waybar
    fuzzel
    wl-clipboard
    cliphist
    waypaper
    soteria
    pavucontrol
    mako
  ];

  environment.etc."xdg/xdg-desktop-portal/portals.conf" = {
    text = ''
      [preferred]
      Hyprland=hyprland;gtk
      default=generic;gtk
    '';
  };

  security.soteria.enable = true;
}
