{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    ghostty
    nemo
    engrampa
    mousepad
    paperwork
    spotify
    imv
    mpv
    brave
    discord
    signal-desktop
    zed-editor
    waybar
    nwg-look
    vial
    (pkgs.lib.hiPrio (
      pkgs.runCommand "launcher-hider-profile" { } ''
        appsDir=$out/share/applications
        mkdir -p $appsDir

        # 1. Hide Neovim Launcher Wrapper
        cat <<EOF > $appsDir/nvim.desktop
        [Desktop Entry]
        Type=Application
        Name=Neovim
        NoDisplay=true
        Exec=nvim %F
        EOF
      ''
    ))
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts-color-emoji
    font-awesome
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glib
      libsecret
      nspr
      nss
      atk
      cups
      dbus
      libdrm
      gtk3
      pango
      cairo
      expat
      alsa-lib
      mesa
    ];
  };
}
