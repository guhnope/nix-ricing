{
  config,
  lib,
  pkgs,
  osConfig,
  username,
  activeTheme ? "gruvbox",
  ...
}:

let
  themes = import ./modules/themes.nix pkgs;
  theme = themes.${activeTheme};
  hyprland = osConfig.programs.hyprland.enable or false;
  waybar = osConfig.programs.waybar.enable or false;
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

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

  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        separator = " ➜ ";
        color = {
          keys = "${theme.accent}";
        };
      };
      modules = [
        "os"
        "host"
        "kernel"
        "uptime"
        "memory"
        "break"
      ];
    };
  };

  xdg.configFile = {
    # --- UI Components ---
    "fuzzel/fuzzel.ini".text = ''
      [main]
      font=JetBrainsMono Nerd Font:size=18
      terminal=ghostty
      prompt="❯ "
      icon-theme=${theme.iconName}
      [colors]
      background=${theme.bg}ff
      text=${theme.fg}ff
      selection=${theme.alt}ff
      prompt=${theme.accent}ff
    '';

    # --- Application Theming ---
    "mpv/mpv.conf".text = ''
      osd-back-color='#${theme.bg}FF'
      osd-color='#${theme.fg}FF'
      osd-border-color='#${theme.accent}FF'
      osd-font-size=24
    '';

    "imv/config".text = ''
      [options]
      background = ${theme.bg}
      overlay_text_color = ${theme.fg}
    '';

    "zed/settings.json".text = builtins.toJSON {
      buffer_font_family = "JetBrainsMono Nerd Font";
      theme = {
        mode = "dark";
      };
    };

    "heroic/config.json".text = builtins.toJSON {
      theme = "dark";
    };
  }
  // lib.optionalAttrs (hyprland) {
    "hypr/hyprland.lua".source = ./hypr/hyprland.lua;
    "hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
    "hypr/hypridle.conf".source = ./hypr/hypridle.conf;
    "hypr/hyprlauncher.conf".source = ./hypr/hyprlauncher.conf;
    "waybar/hyprland.jsonc".source = ./hypr/waybar.jsonc;
  }
  // lib.optionalAttrs (waybar) {
    "waybar/style.css".text = ''
      * { color: #${theme.fg}; }
      window#waybar { background: #${theme.bg}; }
      #workspaces button.active { background: #${theme.accent}; }
    '';
    "wlogout/layout".text = ''
      { "label": "lock", "action": "loginctl lock-session", "text": "Lock", "keybind": "l" }
      { "label": "logout", "action": "loginctl terminate-user $USER", "text": "Logout", "keybind": "e" }
      { "label": "shutdown", "action": "systemctl poweroff", "text": "Shutdown", "keybind": "s" }
      { "label": "reboot", "action": "systemctl reboot", "text": "Reboot", "keybind": "r" }
    '';
    "wlogout/style.css".text = ''
      window { background-color: rgba(0, 0, 0, 0.5); }
      grid { background-color: #${theme.bg}; border: 2px solid #${theme.accent}; border-radius: 10px; padding: 10px; }
      button { background-color: #${theme.bg}; color: #${theme.fg}; border: 2px solid #${theme.accent}; border-radius: 10px; margin: 10px; }
      button:hover { background-color: #${theme.accent}; color: #${theme.bg}; }
      #lock { background-image: url("${theme.iconPkg}/share/icons/${theme.iconName}/apps/scalable/system-lock-screen.svg"); }
    '';
  };

  programs.waybar.enable = waybar;
  services.cliphist.enable = true;
}
