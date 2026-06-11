{ config, pkgs, ... }:

{
  programs.regreet = {
    enable = true;
    theme = {
      package = pkgs.nordic;
      name = "Nordic";
    };
    iconTheme = {
      package = pkgs.nordic;
      name = "Nordic-bluish";
    };
    cursorTheme = {
      package = pkgs.nordic;
      name = "Nordic-cursors";
    };
    font = {
      name = "Inter";
      size = 14;
    };
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
      };
      background = {
        path = ./nord.png;
        fit = "Cover";
      };
      env = {
        GTK_THEME = "Nordic";
        XDG_DATA_DIRS = "${pkgs.nordic}/share:${pkgs.papirus-icon-theme}/share:/run/current-system/sw/share";
      };
    };
    extraCss = ''
      @import url("file://${pkgs.nordic}/share/themes/Nordic/gtk-4.0/gtk.css");
      @import url("file://${pkgs.nordic}/share/themes/Nordic/gtk-4.0/gtk-dark.css");
    '';
  };
  environment.systemPackages = with pkgs; [
    nordic
    papirus-icon-theme
    bibata-cursors
    inter
  ];
}
