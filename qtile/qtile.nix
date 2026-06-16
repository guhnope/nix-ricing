{
  pkgs,
  config,
  lib,
  ...
}:

{
  # Only enable if Qtile is chosen
  config = lib.mkIf config.programs.qtile.enable {
    environment.systemPackages = with pkgs; [
      slurp
      mako
      gtklock
      wpaperd
      pavucontrol
      soteria
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
  };
}
