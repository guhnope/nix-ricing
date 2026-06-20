{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.my-configs.miracle-wm.enable = lib.mkEnableOption "Enable Miracle-WM compositor";

  config = lib.mkIf config.my-configs.miracle-wm.enable {
    environment.systemPackages = [ pkgs.miracle-wm ];

    # This ensures it shows up in your display manager (Greetd/etc)
    environment.etc."wayland-sessions/miracle-wm.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Miracle-WM
        Exec=miracle-wm
        Type=Application
      '';
    };
  };
}
