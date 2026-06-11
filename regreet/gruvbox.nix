{ config, pkgs, ... }:

{
  programs.regreet = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark";
    };
    iconTheme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox Plus Light";
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
        path = ./gruvbox.jpg;
        fit = "Cover";
      };
      env = {
        GTK_THEME = "Gruvbox-Dark";
        XDG_DATA_DIRS = "${pkgs.gruvbox-gtk-theme}/share:${pkgs.papirus-icon-theme}/share:/run/current-system/sw/share";
      };
    };
    extraCss = ''
      @import url("file://${pkgs.gruvbox-gtk-theme}/share/themes/Gruvbox-Dark/gtk-4.0/gtk.css");
      @import url("file://${pkgs.gruvbox-gtk-theme}/share/themes/Gruvbox-Dark/gtk-4.0/gtk-dark.css");
    '';
  };
  environment.systemPackages = with pkgs; [
    gruvbox-gtk-theme
    papirus-icon-theme
    bibata-cursors
    inter
  ];
}
