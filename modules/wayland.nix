{
  pkgs,
  lib,
  activeTheme,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wlogout
    matugen
    grim
    awww
    waybar
    fuzzel
    wl-clipboard
    cliphist
    waypaper
    soteria
    pavucontrol
    slurp
    mako
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
  environment.etc."xdg/xdg-desktop-portal/portals.conf" = {
    text = ''
      [preferred]
      Hyprland=hyprland;gtk
      default=generic;gtk
    '';
  };

  security.soteria.enable = true;
}
