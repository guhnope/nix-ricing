{
  pkgs,
  config,
  lib,
  ...
}:

let
  # Determine if either compositor is enabled
  isSway = config.programs.sway.enable;
  isScroll = config.programs.scroll.enable; # Assuming you add this module
in
{
  config = lib.mkIf (isSway || isScroll) {
    # These tools are universal to both Sway and Scroll
    programs.sway.extraPackages = [ ];

    # 2. Bind the PAM authentication service explicitly for swaylock.
    # Without this link, your custom lockscreen cannot verify security credentials.
    security.pam.services.swaylock = { };

    # 3. Inject your preferred custom ecosystem tools
    environment.systemPackages = with pkgs; [
      swaytools
      swayidle
      swayosd
      swaylock
      swaybg
      swayimg
      swaylock-effects # Your custom locker choice
      swaynotificationcenter
      pavucontrol
      slurp
      soteria
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
