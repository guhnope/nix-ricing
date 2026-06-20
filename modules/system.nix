# packages.nix
{ pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  environment.systemPackages = with pkgs; [
    lazygit
    git
    curl
    wget
    wgnord
    unzip
    nixd
    zip
    tree
    nil
    ripgrep
    fastfetch
  ];
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  programs.dconf.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.polkit.enable = true;
  security.soteria.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = "fastfetch";
  };

}
