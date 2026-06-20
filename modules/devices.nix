{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };
  services.udev.packages = [ pkgs.vial ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    vial
    (pkgs.lib.hiPrio (
      pkgs.runCommand "launcher-hider-profile" { } ''
        appsDir=$out/share/applications
        mkdir -p $appsDir

        cat <<EOF > $appsDir/hp-uiscan.desktop
        [Desktop Entry]
        Type=Application
        Name=HP Linux Imaging and Printing Scanner
        NoDisplay=true
        Exec=hp-uiscan
        EOF

        cat <<EOF > $appsDir/hplip.desktop
        [Desktop Entry]
        Type=Application
        Name=HPLIP Toolbox
        NoDisplay=true
        Exec=hp-toolbox
        EOF

        cat <<EOF > $appsDir/cups.desktop
        [Desktop Entry]
        Type=Application
        Name=Manage Printing
        NoDisplay=true
        Exec=xdg-open http://localhost:631/
        EOF
      ''
    ))
  ];
}
