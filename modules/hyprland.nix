# modules/hyprland.nix
{ pkgs, config, lib, ... }:

{
  config = lib.mkIf config.programs.hyprland.enable {
    services.hypridle.enable = true;
    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-gtk
        ];
        config.common.default = [ "hyprland" "gtk" ];
    };
    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      GTK_THEME = "adw-gtk3-dark";
      NIXOS_OZONE_WL = "1";
    };
  };
}
