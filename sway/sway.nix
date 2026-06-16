# sway/sway.nix
{
  pkgs,
  config,
  lib,
  ...
}:

{
  # Only enable if Sway is chosen
  config = lib.mkIf config.programs.sway.enable {

    # 1. Clear out the default system bundle (foot, wmenu)
    programs.sway.extraPackages = [ ];

    # 2. Bind the PAM authentication service explicitly for swaylock.
    # Without this link, your custom lockscreen cannot verify security credentials.
    security.pam.services.swaylock = { };

    # 3. Inject your preferred custom ecosystem tools
    environment.systemPackages = with pkgs; [
      swaytools
      swaybg
      swayimg
      swayosd
      swaylock-effects # Your custom locker choice
      swaynotificationcenter
      pavucontrol
      slurp
      soteria
      waypaper
      swayidle # Added here as a system tool since services.swayidle is HM-only
    ];

    # 4. XDG Desktop Portals
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      # Use mkDefault so it defers to others if they exist
      config.common.default = lib.mkDefault [ "gtk" ];
    };
  };
}
