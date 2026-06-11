{ config, pkgs, ... }:

{
  programs.regreet = {
    enable = true;
    theme = {
      package = pkgs.everforest-gtk-theme;
      name = "Everforest-Green-Dark";
    };
    iconTheme = {
      package = pkgs.everforest-gtk-theme;
      name = "oomox-Everforest-Dark";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
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
        path = ./everforest.jpg;
        fit = "Cover";
      };
      env = {
        GTK_THEME = "Everforest-Green-Dark";
        XDG_DATA_DIRS = "${pkgs.everforest-gtk-theme}/share:${pkgs.papirus-icon-theme}/share:/run/current-system/sw/share";
      };
    };
    extraCss = ''
      @import url("file://${pkgs.everforest-gtk-theme}/share/themes/Everforest-Green-Dark/gtk-4.0/gtk.css");
      @import url("file://${pkgs.everforest-gtk-theme}/share/themes/Everforest-Green-Dark/gtk-4.0/gtk-dark.css");
    '';
  };
  environment.systemPackages = with pkgs; [
    everforest-gtk-theme
    papirus-icon-theme
    bibata-cursors
    inter
  ];
}
