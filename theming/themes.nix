pkgs:

{
  catppuccin-mocha = {
    bg = "1e1e2e";
    fg = "cdd6f4";
    accent = "cba6f7";
    alt = "89b4fa";
    warn = "f38ba8";
    ghostty = "Catppuccin Mocha";
    gtkName = "catppuccin-mocha-mauve-standard";
    gtkPkg = pkgs.catppuccin-gtk.override {
      accents = [ "mauve" ];
      variant = "mocha";
    };
    iconName = "Papirus-Dark";
    iconPkg = pkgs.papirus-icon-theme;
    cursorName = "Catppuccin Mocha Lavender";
    cursorPkg = pkgs.catppuccin-cursors.mochaLavender;
    cursorSize = 24;
  };

  everforest = {
    bg = "2d353b";
    fg = "d3c6aa";
    accent = "a7c080";
    alt = "7fbbb3";
    warn = "e67e80";
    ghostty = "Everforest Dark Hard";
    gtkName = "Everforest-Green-Dark";
    gtkPkg = pkgs.everforest-gtk-theme;
    iconName = "Gruvbox-Plus-Light";
    iconPkg = pkgs.gruvbox-plus-icons;
    cursorName = "Everforest cursors";
    cursorPkg = pkgs.everforest-cursors;
    cursorSize = 24;
  };

  gruvbox = {
    bg = "282828";
    fg = "ebdbb2";
    accent = "d65d0e";
    alt = "b8bb26";
    warn = "fb4934";
    ghostty = "Gruvbox Material Dark";
    gtkName = "Gruvbox-Dark";
    gtkPkg = pkgs.gruvbox-gtk-theme;
    iconName = "Gruvbox-Plus-Dark";
    iconPkg = pkgs.gruvbox-plus-icons;
    cursorName = "capitaine-cursors";
    cursorPkg = pkgs.capitaine-cursors;
    cursorSize = 24;
  };

  nord = {
    bg = "2e3440";
    fg = "d8dee9";
    accent = "88c0d0";
    alt = "81a1c1";
    warn = "bf616a";
    ghostty = "Nord";
    gtkName = "Nordic";
    gtkPkg = pkgs.nordic;
    iconName = "Nordzy";
    iconPkg = pkgs.nordzy-icon-theme;
    cursorName = "Nordic-cursors";
    cursorPkg = pkgs.nordic;
    cursorSize = 24;
  };

  tokyonight = {
    bg = "1a1b26";
    fg = "a9b1d6";
    accent = "7aa2f7";
    alt = "cba6f7";
    warn = "f7768e";
    ghostty = "TokyoNight";
    gtkName = "Tokyonight-Dark";
    gtkPkg = pkgs.tokyonight-gtk-theme;
    iconName = "Dracula";
    iconPkg = pkgs.dracula-icon-theme;
    cursorName = "Bibata-Modern-Classic";
    cursorPkg = pkgs.bibata-cursors;
    cursorSize = 24;
  };

  osaka-jade = {
    bg = "111c18";
    fg = "f7e8b2";
    accent = "81b8a8";
    alt = "72cfa3";
    warn = "db9f9c";
    ghostty = "Osaka Jade";
    gtkName = "Arc-Dark"; # Osaka Jade often pairs well with minimalist dark themes
    gtkPkg = pkgs.arc-theme;
    iconName = "Papirus-Dark";
    iconPkg = pkgs.papirus-icon-theme;
    cursorName = "Bibata-Modern-Classic";
    cursorPkg = pkgs.bibata-cursors;
    cursorSize = 24;
  };

  solarized-dark = {
    bg = "002b36";
    fg = "839496";
    accent = "268bd2";
    alt = "859900";
    warn = "dc322f";
    ghostty = "Solarized Dark";
    gtkName = "Solarized-Dark";
    gtkPkg = pkgs.solarized-gtk-theme;
    iconName = "Papirus-Dark";
    iconPkg = pkgs.papirus-icon-theme;
    cursorName = "Adwaita";
    cursorPkg = pkgs.adwaita-icon-theme;
    cursorSize = 24;
  };
}
