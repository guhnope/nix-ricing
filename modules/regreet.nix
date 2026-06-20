{
  config,
  pkgs,
  activeTheme,
  ...
}:

let
  allThemes = import ../theming/themes.nix pkgs;
  theme = allThemes.${activeTheme};
in
{
  programs.regreet = {
    enable = true;
    theme = {
      package = theme.gtkPkg;
      name = theme.gtkName;
    };
    iconTheme = {
      package = theme.iconPkg;
      name = theme.iconName;
    };
    cursorTheme = {
      package = theme.cursorPkg;
      name = theme.cursorName;
    };
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
      };
      env = {
        GTK_THEME = theme.gtkName;
      };
    };
  };
  environment.systemPackages = [
    theme.gtkPkg
    theme.iconPkg
    theme.cursorPkg
  ];
}
