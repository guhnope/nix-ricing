# packages.nix
{ pkgs, ... }:

{

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
    (pkgs.lib.hiPrio (
      pkgs.runCommand "launcher-hider-profile" { } ''
        appsDir=$out/share/applications
        mkdir -p $appsDir

        cat <<EOF > $appsDir/nixos-manual.desktop
        [Desktop Entry]
        Type=Application
        Name=NixOS Manual
        NoDisplay=true
        Exec=nixos-help
        EOF
      ''
    ))
  ];
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  programs.dconf.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.pam.services.gtklock = { };
  security.polkit.enable = true;
  security.soteria.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = "fastfetch";
  };

}
