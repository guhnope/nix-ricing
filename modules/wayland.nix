{
  pkgs,
  lib,
  config,
  activeTheme,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    wlogout
    stasis
    grim
    awww
    waybar
    fuzzel
    wl-clipboard
    cliphist
    waypaper
    soteria
    gtklock
    pavucontrol
    slurp
    mako
    hyprpicker
    matugen
    (pkgs.lib.hiPrio (
      pkgs.runCommand "launcher-hider-profile" { } ''
        appsDir=$out/share/applications
        mkdir -p $appsDir

        cat <<EOF > $appsDir/org.pulseaudio.pavucontrol.desktop
        [Desktop Entry]
        Type=Application
        Name=Volume Control
        NoDisplay=true
        Exec=nvim %F
        EOF
      ''
    ))
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-luminous
    ];
    config = {
      common = {
        default = [ "gtk" ]; # Fallback for everything else
        "org.freedesktop.impl.portal.ScreenCast" = [ "luminous" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "luminous" ];
        "org.freedesktop.impl.portal.InputCapture" = [ "luminous" ];
        "org.freedesktop.impl.portal.Settings" = [ "luminous" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "luminous" ];
      };
    };
  };
  services.dbus.packages =
    lib.optionals config.programs.hyprland.enable [ pkgs.xdg-desktop-portal-hyprland ]
    ++ lib.optionals config.programs.niri.enable [ pkgs.xwayland-satellite ];

}
