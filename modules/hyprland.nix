# modules/hyprland.nix
{ pkgs, config, lib, ... }:

{
  config = lib.mkIf config.programs.hyprland.enable {
    environment.systemPackages = with pkgs; [
      hyprlock
      hyprpaper
      hyprshot
      hypridle
      hyprnotify
      hyprpicker
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
