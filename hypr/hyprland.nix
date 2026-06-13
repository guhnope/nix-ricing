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
      fuzzel # Because bwrap issues on Nix breaks hyprlauncher, noctalia and walker
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
