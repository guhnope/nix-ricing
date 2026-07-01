{
  pkgs,
  config,
  inputs,
  activeTheme,
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };
  environment.systemPackages = with pkgs; [
    neovim
    ghostty
    caja
    engrampa
    mousepad
    paperwork
    spotify
    imv
    mpv
    discord
    signal-desktop
    zed-editor
    ffmpegthumbnailer
    gdk-pixbuf
    nwg-look
    popsicle
    bitwarden-desktop
    (pkgs.lib.hiPrio (
      pkgs.runCommand "launcher-hider-profile" { } ''
        appsDir=$out/share/applications
        mkdir -p $appsDir

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
        Name=GTK Settings
        NoDisplay=true
        Exec=nwg-look
        EOF

        cat <<EOF > $appsDir/caja-file-management-properties.desktop
        [Desktop Entry]
        Type=Application
        Name=File Management
        NoDisplay=true
        Exec=caja-file-management-properties
        EOF

        cat <<EOF > $appsDir/caja-browser.desktop
        [Desktop Entry]
        Type=Application
        Name=Files
        GenericName=File Manager
        Comment=Browse the file system with the Caja File Manager
        Icon=system-file-manager
        TryExec=caja
        Exec=caja %U
        Terminal=false
        Categories=GTK;System;Core;FileManager;
        MimeType=inode/directory;package;
        NoDisplay=false
        EOF

      ''
    ))
  ];

  imports = [ inputs.helium-flake.nixosModules.default ];

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
      "--enable-features=UseOzonePlatform"
    ];
  };

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
