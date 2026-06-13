# home.nix
{
  config,
  lib,
  pkgs,
  osConfig,
  username,
  activeTheme ? null,
  ...
}:

let
  hyprland = osConfig.programs.hyprland.enable or false;
  niri = osConfig.programs.niri.enable or false;
  waybar = osConfig.programs.waybar.enable or false;
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  # ----------------------------------------------------------------
  # 🖥️ DYNAMIC DOTFILE CONFIGURATION MATRIX
  # ----------------------------------------------------------------
  xdg.configFile = {
    # Any static configurations that don't change based on session go here
    # e.g., "ghostty/config".source = ./configs/ghostty;
  }
  // lib.optionalAttrs (hyprland) {
    "hypr/hyprland.lua".source = ./configs/hyprland.lua;
    "hypr/hyprpaper.conf".source = ./configs/hyprpaper.conf;
    "hypr/hypridle.conf".source = ./configs/hypridle.conf;
    "hypr/hyprlauncher.conf".source = ./configs/hyprlauncher.conf;
    "fuzzel/fuzzel.ini".source = ./configs/fuzzel.ini;
  }
  // lib.optionalAttrs (niri) {
    "niri/config.kdl".source = ./configs/niri.kdl;
  }
  // lib.optionalAttrs (waybar) {
    "waybar/config.jsonc".source = ./configs/waybar-config.jsonc;
    "waybar/style.css".source = ./configs/waybar-style.css;
  };

  # ----------------------------------------------------------------
  # 🤖 HOME MANAGER WAYBAR SERVICE LIFECYCLE
  # ----------------------------------------------------------------
  programs.waybar = {
    enable = waybar;
  };

  # Fine-tune the systemd service so it only spins up after Niri/Hyprland
  # hydrates systemd with your session's active environment variables.
  systemd.user.services.waybar = lib.mkIf waybar {
    Unit = {
      Description = "Highly customizable Wayland bar";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      # Ensures the bar automatically spins back up if it experiences an unexpected crash
      Restart = "on-failure";
      RestartSec = "2s";
    };
  };

  # ----------------------------------------------------------------
  # 🐚 SHELL CONFIGURATION
  # ----------------------------------------------------------------
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
      fastfetch
    '';
  };
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];
    extraPackages = [
      pkgs.nixd
      pkgs.lua-language-server
    ];
  };
}
