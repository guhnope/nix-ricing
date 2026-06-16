{
  config,
  lib,
  pkgs,
  activeTheme ? "gruvbox",
  ...
}:

let
  themes = import ./themes.nix pkgs;
  theme = themes.${activeTheme};
  waybarEnabled = config.programs.waybar.enable or false;
  # Checking if sway is enabled to toggle its specific configs safely
  swayEnabled = config.programs.sway.enable or false;
in
{
  xdg.configFile = lib.foldr lib.recursiveUpdate { } [
    # =====================================================================
    # 1. Core/Static App Configurations (Always Generated)
    # =====================================================================
    {
      "fuzzel/fuzzel.ini".text = ''
        [main]
        font=JetBrainsMono Nerd Font:size=22
        lines=20
        terminal=ghostty
        prompt="❯ "
        icon-theme=${theme.iconName}
        [icons]
        icon-size=64
        icon-theme=${theme.iconName}
        [colors]
        background=${theme.bg}ff
        text=${theme.fg}ff
        selection=${theme.alt}ff
        prompt=${theme.accent}ff
      '';

      "mpv/mpv.conf".text = "background=#${theme.bg}";

      "imv/config".text = ''
        [options]
        background = ${theme.bg}
        overlay_text_color = ${theme.fg}
      '';

      "ghostty/config".text = ''
        theme = ${theme.ghostty}
        font-family = "JetBrainsMono Nerd Font"
        font-size = 14
        window-decoration = false
        confirm-close-surface = false
      '';

      "wlogout/layout".text = ''
        { "label": "lock", "action": "loginctl lock-session", "text": "Lock", "keybind": "l" }
        { "label": "logout", "action": "loginctl terminate-user $USER", "text": "Logout", "keybind": "e" }
        { "label": "shutdown", "action": "systemctl poweroff", "text": "Shutdown", "keybind": "s" }
        { "label": "reboot", "action": "systemctl reboot", "text": "Reboot", "keybind": "r" }
      '';

      "wlogout/style.css".text = ''
        window { background-color: rgba(0, 0, 0, 0.5); }
        grid {
            margin: 300px 500px;
            background-color: #${theme.bg};
            border: 2px solid #${theme.accent};
            border-radius: 10px;
            padding: 10px;
        }
        button {
            background-color: #${theme.bg};
            color: #${theme.fg};
            border: 2px solid #${theme.accent};
            border-radius: 10px;
            margin: 10px;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 100px;
        }
        button:hover { background-color: #${theme.accent}; color: #${theme.bg}; }
        #lock { background-image: url("${theme.iconPkg}/share/icons/${theme.iconName}/apps/scalable/system-lock-screen.svg"); }
        #logout { background-image: url("${theme.iconPkg}/share/icons/${theme.iconName}/apps/scalable/logout_highlight.svg"); }
        #shutdown { background-image: url("${theme.iconPkg}/share/icons/${theme.iconName}/apps/scalable/system-shutdown.svg"); }
        #reboot { background-image: url("${theme.iconPkg}/share/icons/${theme.iconName}/apps/scalable/system-reboot.svg"); }
      '';
    }

    # =====================================================================
    # 2. Conditional Waybar Integration
    # =====================================================================
    (lib.optionalAttrs waybarEnabled {
      "waybar/style.css".text = ''
        * { color: #${theme.fg}; }
        window#waybar { background: #${theme.bg}; }
        #workspaces button.active { background: #${theme.accent}; }
      '';
    })

    # =====================================================================
    # 3. Conditional Sway Desktop Ecosystem Tools
    # =====================================================================
    (lib.optionalAttrs swayEnabled {
      "swaync/config.json".text = builtins.toJSON {
        "$schema" = "/etc/xdg/swaync/configSchema.json";
        positionX = "right";
        positionY = "top";
        layer = "top";
        control-center-layer = "top";
        layer-shell = true;
        cssPriority = "application";
        widgets = [
          "inhibitors"
          "title"
          "dnd"
          "mpris"
          "notifications"
        ];
      };

      "swaync/style.css".text = ''
        @define-color bg #${theme.bg};
        @define-color accent #${theme.accent};
        @define-color text #${theme.fg};
        .notification { background: @bg; border: 1px solid @accent; }
        .control-center { background: @bg; color: @text; }
      '';

      "swaylock/config".text = ''
        color=${theme.bg}
        ring-color=${theme.accent}
      '';
    })
  ];
}
