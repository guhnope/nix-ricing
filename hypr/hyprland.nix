# modules/hyprland.nix
{
  pkgs,
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.programs.hyprland.enable {
    environment.systemPackages = with pkgs; [
      hyprlock
      hyprpaper
      hyprshot
      hypridle
      hyprnotify
      hyprsysteminfo
      hyprpwcenter
      hyprpicker
      hyprtoolkit
      hyprshutdown
      hyprlauncher
      hyprpolkitagent # Add the package here
      fuzzel
    ];

    services.hypridle.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      config.common.default = [ "hyprland" ];
    };
  };
}
