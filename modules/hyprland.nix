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
      hyprpicker
      fuzzel # Because bwrap issues on Nix breaks hyprlauncher, noctalia and walkerland
    ];
    services.hypridle.enable = true;
    programs.uwsm = {
      enable = true;

    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      config.common.default = [ "hyprland" ];
    };
  };
}
