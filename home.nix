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

  xdg.configFile = {
    # Any static configurations that don't change based on session go here
    # e.g., "ghostty/config".source = ./configs/ghostty;
  }
  // lib.optionalAttrs (hyprland) {
    "hypr/hyprland.lua".source = ./hypr/hyprland.lua;
    "hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
    "hypr/hypridle.conf".source = ./hypr/hypridle.conf;
    "hypr/hyprlauncher.conf".source = ./hypr/hyprlauncher.conf;
    "fuzzel/fuzzel.ini".source = ./hypr/fuzzel.ini;
    "waybar/hypr.jsonc".source = ./hypr/hypr-waybar.jsonc;
  }
  // lib.optionalAttrs (niri) {
    "niri/config.kdl".source = ./configs/niri.kdl;
  }
  // lib.optionalAttrs (waybar) {
    "waybar/config.jsonc".source = ./configs/waybar-config.jsonc;
    "waybar/style.css".source = ./configs/waybar-style.css;
  };

  programs.waybar = {
    enable = waybar;
  };
  services.cliphist = {
    enable = true;
    allowImages = true;
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
