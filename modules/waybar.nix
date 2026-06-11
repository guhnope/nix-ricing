# modules/waybar.nix
{ pkgs, lib, config, ... }:

lib.mkIf config.programs.waybar.enable {
  environment.systemPackages = with pkgs; [
    waybar
    wofi
    wpaperd
    wlogout
    matugen
    grim
    slurp
    sway-contrib.grimshot
    hyprpolkitagent
  ];
}
