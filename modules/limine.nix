# modules/limine.nix
{ pkgs, activeTheme, ... }:

let
  allThemes = import ../theming/themes.nix pkgs;
  theme = allThemes.${activeTheme};
in
{
  boot.loader.systemd-boot.enable = false;
  boot.loader.limine = {
    enable = true;
    enrollConfig = true;
    panicOnChecksumMismatch = true;
    maxGenerations = 10;
    extraConfig = ''
      THEME_BACKGROUND=${theme.bg}
      THEME_FOREGROUND=${theme.fg}
      THEME_HIGHLIGHT=${theme.accent}
    '';
  };
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.efi.canTouchEfiVariables = true;
}
