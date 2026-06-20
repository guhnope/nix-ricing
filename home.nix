{
  config,
  lib,
  pkgs,
  osConfig,
  username,
  activeTheme ? "gruvbox",
  ...
}:
{
  imports = [
    ./theming/configs.nix
  ];

  # Move the 'let' block here, inside the main set
  config =
    let
      themes = import ./theming/themes.nix pkgs;
      theme = themes.${activeTheme};
      hyprland = osConfig.programs.hyprland.enable or false;
      niri = osConfig.programs.niri.enable or false;
      qtile = osConfig.services.xserver.windowManager.qtile.enable or false;
      mango = osConfig.programs.mangowc.enable or false;
      sway = osConfig.programs.sway.enable or false;
      waybar = osConfig.programs.waybar.enable or false;
    in
    {
      # All your settings go inside this 'in' block
      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
      programs.fastfetch = {
        enable = true;
      };
      services.cliphist.enable = true;
      # GTK Theme Integration
      gtk = {
        enable = true;
        theme = {
          name = theme.gtkName;
          package = theme.gtkPkg;
        };
        iconTheme = {
          name = theme.iconName;
          package = theme.iconPkg;
        };
        cursorTheme = {
          name = theme.cursorName;
          package = theme.cursorPkg;
          size = theme.cursorSize;
        };
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = theme.gtkName;
          icon-theme = theme.iconName;
          cursor-theme = theme.cursorName;
        };
      };

      xdg.configFile =
        { }
        // lib.optionalAttrs (hyprland) {
          "hypr/hyprland.lua".source = ./hypr/hyprland.lua;
          "hypr/hypridle.conf".source = ./hypr/hypridle.conf;
          "hypr/hyprlauncher.conf".source = ./hypr/hyprlauncher.conf;
          "waybar/hyprland.jsonc".source = ./hypr/waybar.jsonc;
        }
        // lib.optionalAttrs (niri) {
          "niri/config.kdl".source = ./niri/config.kdl;
          "niri/niri-portals.conf".source = ./niri/niri-portals.conf;
          "waybar/niri.jsonc".source = ./niri/waybar.jsonc;
        }
        // lib.optionalAttrs (qtile) {
          "qtile/config.py".source = ./qtile/config.py;
        }
        // lib.optionalAttrs (sway) {
          "sway/config".source = ./sway/config;
          "waybar/sway.jsonc".source = ./sway/waybar.jsonc;
        }
        // lib.optionalAttrs osConfig.programs.scroll.enable {
          "scroll/config".source = ./sway/config;
          "waybar/sway.jsonc".source = ./sway/waybar.jsonc;
        }

        // lib.optionalAttrs (mango) {
          "mango/config.conf".source = ./mango/config.conf;
          "mango/bind.conf".source = ./mango/bind.conf;
          "mango/rule.conf".source = ./mango/rule.conf;
          "waybar/mango.jsonc".source = ./mango/waybar.jsonc;
        };

      programs.waybar = {
        enable = true; # Keep this to install the package
        systemd.enable = false; # This disables the systemd service automatically
      };
      systemd.user.services.waybar = {
        Service = {
          ExecStart = "/bin/false";
        };
        Install = {
          WantedBy = [ ]; # Remove it from startup targets
        };
      };
    };
}
