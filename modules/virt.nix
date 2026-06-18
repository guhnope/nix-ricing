{
  config,
  pkgs,
  inputs,
  username,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    qemu_full
    virt-viewer
    virt-manager
  ];
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true; # Needed for TPM (Windows 11)
  };
  services.dbus.packages = [ pkgs.gnome-boxes ];
  services.udev.packages = [ pkgs.libvirt ];
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.libvirt.unix.manage" && subject.user == "${username}) {
        return polkit.Result.YES;
      }
    });
  '';
}
