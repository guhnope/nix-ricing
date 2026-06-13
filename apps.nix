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

        cat <<EOF > $appsDir/nwg-look.desktop
        [Desktop Entry]
        Type=Application
        Name=nwg-look
        NoDisplay=true
        Exec=nwg-look
        EOF

        cat <<EOF > $appsDir/qt6ct.desktop
        [Desktop Entry]
        Type=Application
        Name=Qt6 Configuration Tool
        NoDisplay=true
        Exec=qt6ct
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
