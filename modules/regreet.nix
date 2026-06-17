{
  config,
  pkgs,
  activeTheme,
  ...
}:

let
  # Pass 'pkgs' to the function to get the actual theme set
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
        # This is CRITICAL for system-level GTK apps
        GTK_THEME = theme.gtkName;
      };
    };
  };

  # Ensure the packages are available to the system
  environment.systemPackages = [
    theme.gtkPkg
    theme.iconPkg
    theme.cursorPkg
  ];
}
