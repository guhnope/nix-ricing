pkgs: {
  tokyonight = {
    bg = "1a1b26";
    fg = "a9b1d6";
    accent = "7aa2f7";
    alt = "cba6f7";
    warn = "f7768e";

    gtkName = "TokyoNight";
    gtkPkg = pkgs.tokyonight-gtk-theme;
    iconName = "aogami-dark";
    iconPkg = pkgs.aogami-icon-theme;

    # 🖱️ Cursor Mapping
    cursorName = "Bibata-Modern-Classic";
    cursorPkg = pkgs.bibata-cursors;
    cursorSize = 24;
  };

  catppuccin-mocha = {
    bg = "1e1e2e";
    fg = "cdd6f4";
    accent = "cba6f7";
    alt = "89b4fa";
    warn = "f38ba8";

    gtkName = "Catppuccin-Mocha-Standard-Lavender-Dark";
    gtkPkg = pkgs.catppuccin-gtk.override {
      accents = [ "lavender" ];
      variant = "mocha";
    };
    iconName = "Papirus-Dark";
    iconPkg = pkgs.papirus-icon-theme;

    # 🖱️ Cursor Mapping
    cursorName = "Catppuccin-Mocha-Lavender-Cursors";
    cursorPkg = pkgs.catppuccin-cursors.mochaLavender;
    cursorSize = 24;
  };

  gruvbox = {
    bg = "282828";
    fg = "ebdbb2";
    accent = "d65d0e";
    alt = "b8bb26";
    warn = "fb4934";

    gtkName = "Gruvbox-Dark";
    gtkPkg = pkgs.gruvbox-gtk-theme;
    iconName = "Gruvbox-Plus-Dark";
    iconPkg = pkgs.gruvbox-plus-icons;

    # 🖱️ Cursor Mapping
    cursorName = "capitaine-cursors";
    cursorPkg = pkgs.capitaine-cursors; # Includes beautiful matching organic curves
    cursorSize = 24;
  };

  nord = {
    bg = "2e3440";
    fg = "d8dee9";
    accent = "88c0d0";
    alt = "81a1c1";
    warn = "bf616a";

    gtkName = "Nordic";
    gtkPkg = pkgs.nordic;
    iconName = "Zafiro-Nord-Dark";
    iconPkg = pkgs.zafiro-icons;

    # 🖱️ Cursor Mapping
    cursorName = "Nordzy-cursors";
    cursorPkg = pkgs.nordzy-cursors;
    cursorSize = 24;
  };

  everforest = {
    bg = "2d353b";
    fg = "d3c6aa";
    accent = "a7c080";
    alt = "7fbbb3";
    warn = "e67e80";

    gtkName = "Everforest-Dark-B";
    gtkPkg = pkgs.everforest-gtk-theme;
    iconName = "Papirus-Dark";
    iconPkg = pkgs.papirus-icon-theme;

    # 🖱️ Cursor Mapping
    cursorName = "Phinger-Cursors-Light";
    cursorPkg = pkgs.phinger-cursors; # Flat, clean geometry that fits Everforest perfectly
    cursorSize = 24;
  };
}
