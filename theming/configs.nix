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
  waybar = config.programs.waybar.enable or false;
in
{
  xdg.configFile = {
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

    "ghostty/config.ghostty".text = ''
      theme = ${theme.ghostty}
      font-family = "JetBrainsMono Nerd Font"
      font-size = 14
      window-decoration = false
      confirm-close-surface = false
    '';
  }
  // lib.optionalAttrs (waybar) {
    "waybar/style.css".text = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 13px;
          font-weight: bold;
      }
      window#waybar {
          background-color: #${theme.bg};
          color: #${theme.fg};
          border-bottom: 2px solid #${theme.alt}; /* Using 'alt' for subtle borders */
      }
      #custom-launcher, #taskbar, #clock, #tray, #pulseaudio, #network, #custom-power, #workspaces {
          background-color: #${theme.alt}; /* Use a slightly different shade if your theme supports it */
          color: #${theme.fg};
          padding: 0px 15px;
          margin: 4px 4px;
          border: 1px solid #${theme.accent};
          border-radius: 8px;
      }
      #custom-launcher { color: #${theme.accent}; }
      #custom-launcher:hover { background-color: #${theme.accent}; color: #${theme.bg}; }
      #workspaces button.active, #workspaces button.focused {
          color: #${theme.accent};
          font-weight: bold;
      }
      #clock { color: #${theme.accent}; }
      #pulseaudio { color: #${theme.alt}; }
      #network { color: #${theme.accent}; }
      #custom-power { color: #${theme.warn}; }
      #custom-power:hover { background-color: #${theme.warn}; color: #${theme.bg}; }
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
  };
}
