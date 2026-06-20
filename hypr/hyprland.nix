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
      hyprpwcenter
      hyprpicker
      hyprtoolkit
      hyprshutdown
      hyprlauncher
      hyprpolkitagent # Add the package here
      fuzzel
      (pkgs.lib.hiPrio (
        pkgs.runCommand "launcher-hider-profile" { } ''
          appsDir=$out/share/applications
          mkdir -p $appsDir

          cat <<EOF > $appsDir/hyprpwcenter.desktop
          [Desktop Entry]
          Type=Application
          Name=Pipewire Control Center
          NoDisplay=true
          Exec=hyprpwcenter
          EOF
        ''
      ))
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
