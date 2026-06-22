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
      hyprtoolkit
      hyprshutdown
      hyprlauncher
    ];

    services.hypridle.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      config.common.default = lib.mkForce [ "hyprland" ];
    };
  };
}
