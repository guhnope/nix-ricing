# home.nix
{ config, lib, pkgs, osConfig, username, activeTheme ? null, ... }:
let
  hyprland = osConfig.programs.hyprland.enable or false;
  niri     = osConfig.programs.niri.enable or false;
  noctalia = osConfig.programs.noctalia.enable or false;
  waybar   = osConfig.programs.waybar.enable or false;
  labwc    = osConfig.programs.labwc.enable or false;
  qtile    = osConfig.services.xserver.windowManager.qtile.enable or false;
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  # 🖥️ DYNAMIC CONDITIONING MATRIX
  xdg.configFile = {
    # Static configs go here
  }
  // lib.optionalAttrs (hyprland) {
    "hypr/hyprland.lua".source = ./configs/hyprland.lua;
  }

  // lib.optionalAttrs (niri) {
    "niri/config.kdl".source = ./configs/niri.kdl;
  }

  // lib.optionalAttrs (waybar) {
    "waybar/config.jsonc".source = ./configs/waybar-config.jsonc;
    "waybar/style.css".source = ./configs/waybar-style.css;
    "wofi/config".source = ./configs/wofi-config;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
      fastfetch
    '';
  };
}
