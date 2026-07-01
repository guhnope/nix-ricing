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
    (import ./theming/configs.nix {
      inherit
        config
        lib
        pkgs
        osConfig
        activeTheme
        ;
    })
  ];

  config =
    let
      themes = import ./theming/themes.nix pkgs;
      theme = themes.${activeTheme};
      hyprland = osConfig.programs.hyprland.enable or false;
      niri = osConfig.programs.niri.enable or false;
      qtile = osConfig.services.xserver.windowManager.qtile.enable or false;
      mango = osConfig.programs.mangowc.enable or false;
      sway = osConfig.programs.sway.enable or false;
      river-classic = osConfig.programs.river.enable or false;
    in
    {
      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
      programs.fastfetch = {
        enable = true;
      };
      home.packages = with pkgs; [
        keepassxc
      ];
      services.cliphist.enable = true;
      services.swayosd = {
        enable = true;
        topMargin = 0.9;
      };
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
      home.pointerCursor = {
        name = theme.cursorName;
        package = theme.cursorPkg;
        size = theme.cursorSize;

        gtk.enable = true;
        x11.enable = true;
      };
      home.sessionVariables = {
        XCURSOR_THEME = theme.cursorName;
        XCURSOR_SIZE = "${toString theme.cursorSize}";
      };
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = theme.gtkName;
          icon-theme = theme.iconName;
          cursor-theme = theme.cursorName;
        };
      };

      xdg.configFile = {
        "ironbar/config.toml".source = ./configs/ironbar.toml;
      }
      // lib.optionalAttrs (hyprland) {
        "hypr/hyprland.lua".source = ./configs/hyprland.lua;
        "waybar/hyprland.jsonc".source = ./waybar/hypr.jsonc;
      }
      // lib.optionalAttrs (niri) {
        "niri/config.kdl".source = ./configs/niri.kdl;
        "waybar/niri.jsonc".source = ./waybar/niri.jsonc;
      }
      // lib.optionalAttrs (qtile) {
        "qtile/config.py".source = ./configs/qtile.py;
      }
      // lib.optionalAttrs (sway) {
        "sway/config".source = ./configs/sway-config;
        "sway/config.json".source = ./configs/sway.json;
        "waybar/sway.jsonc".source = ./waybar/sway.jsonc;
      }
      // lib.optionalAttrs osConfig.programs.scroll.enable {
        "scroll/config".source = ./sway/config;
        "waybar/sway.jsonc".source = ./waybar/sway.jsonc;
      }
      // lib.optionalAttrs osConfig.programs.river-classic.enable {
        "river/init" = {
          source = ./configs/river-init;
          executable = true;
        };
        "waybar/river.jsonc".source = ./waybar/river.jsonc;
      }
      // lib.optionalAttrs (mango) {
        "mango/config.conf".source = ./configs/mangoconfig.conf;
        "mango/bind.conf".source = ./configs/mangobind.conf;
        "mango/rule.conf".source = ./configs/mangorule.conf;
        "waybar/mango.jsonc".source = ./waybar/mango.jsonc;
      };

      systemd.user.services.stasis = {
        Unit = {
          Description = "Stasis Wayland idle manager";
          After = [ "graphical-session.target" ];
        };

        Service = {
          ExecStart = "${pkgs.stasis}/bin/stasis";
          Restart = "always";
        };

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
      programs.waybar = {
        enable = true;
        systemd.enable = false;
      };
      systemd.user.services.waybar = {
        Service = {
          ExecStart = "/bin/false";
        };
        Install = {
          WantedBy = [ ];
        };
      };
    };
}
